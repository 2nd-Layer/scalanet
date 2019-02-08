package io.iohk.scalanet.peergroup

import java.nio.ByteBuffer

import cats.data.Kleisli
import io.iohk.scalanet.messagestream.MessageStream
import monix.eval.Task

import scala.language.higherKinds

sealed trait PeerGroup[A, F[_]] {
  def sendMessage(address: A, message: ByteBuffer): F[Unit]
  def shutdown(): F[Unit]
  def messageStream(): MessageStream[ByteBuffer]
}

object PeerGroup {

  type Lift[F[_]] = Kleisli[F, Task[Unit], Unit]

  trait TerminalPeerGroup[A, F[_]] extends PeerGroup[A, F]

  case class InitializationError(message: String, cause: Throwable)
}