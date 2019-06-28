package io.iohk.scalanet.codec

import java.nio.ByteBuffer

import io.iohk.decco.{BufferInstantiator, Codec}
import io.iohk.decco.Codec.{DecodeResult, Failure}
import io.iohk.scalanet.codec.FramingCodec.State._
import io.iohk.scalanet.codec.FramingCodec._

import scala.collection.mutable

class FramingCodec[T](val messageCodec: Codec[T], val maxBufferLength: Int = Int.MaxValue) extends StreamCodec[T] {

  private[codec] var state: State = LengthExpected
  private[codec] var length: Int = 0
  private[codec] var db: ByteBuffer = ByteBuffer.allocate(0)
  private[codec] val nlb = ByteBuffer.allocate(4)

  override def streamDecode[B](source: B)(implicit bi: BufferInstantiator[B]): Seq[T] = this.synchronized {
    val b = bi.asByteBuffer(source)
    val s = mutable.ListBuffer[T]()
    while (b.hasRemaining) {
      state match {
        case LengthExpected =>
          while (b.remaining() > 0 && nlb.position() < 4) {
            nlb.put(b.get())
          }
          if (nlb.position() == 4) {
            val l = nlb.getInt(0)
            if (l > maxBufferLength) {
              nlb.clear()
              throw new IllegalArgumentException(
                s"Refusing to decode buffer with length header greater than maxLength ($l > $maxBufferLength)."
              )
            } else {
              length = nlb.getInt(0)
              nlb.clear()
              db = ByteBuffer.allocate(length)
              state = BytesExpected
            }
          }
        case BytesExpected =>
          val remainingBytes = length - db.position()
          if (b.remaining() >= remainingBytes) {
            readUnchecked(remainingBytes, b, db)
            db.position(0)
            messageCodec.decode(bi.asB(db)).foreach(message => s += message)
            state = LengthExpected
          } else { // (b.remaining() < remainingBytes)
            readUnchecked(b.remaining(), b, db)
          }
      }
    }
    s
  }

  override def size(t: T): Int = 4 + messageCodec.size(t)

  override def encodeImpl(t: T, start: Int, destination: ByteBuffer): Unit = {
    destination.putInt(start, destination.capacity() - 4)
    messageCodec.encodeImpl(t, 4, destination)
  }

  override def decodeImpl(start: Int, source: ByteBuffer): Either[Failure, DecodeResult[T]] = {
    messageCodec.decodeImpl(start + 4, source)
  }

  override def cleanSlate: FramingCodec[T] = new FramingCodec[T](messageCodec)
}

object FramingCodec {

  trait State

  object State {
    case object LengthExpected extends State
    case object BytesExpected extends State
  }

  private def readUnchecked(n: Int, from: ByteBuffer, to: ByteBuffer): Unit = {
    var m: Int = 0
    while (m < n) {
      to.put(from.get())
      m += 1
    }
  }
}