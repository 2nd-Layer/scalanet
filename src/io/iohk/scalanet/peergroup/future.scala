package io.iohk.scalanet.peergroup

import cats.data.Kleisli
import io.iohk.scalanet.peergroup.PeerGroup.Lift
import monix.execution.Scheduler

import scala.concurrent.{ExecutionContext, Future}

object future {

  type PeerGroup[A] = io.iohk.scalanet.peergroup.PeerGroup[A, Future]

  type TerminalPeerGroup[A] = io.iohk.scalanet.peergroup.PeerGroup.TerminalPeerGroup[A, Future]

  type UDPPeerGroup = io.iohk.scalanet.peergroup.PeerGroup.UDPPeerGroup[Future]

  implicit def liftFuture(implicit ec: ExecutionContext): Lift[Future] =
    Kleisli(_.runAsync(Scheduler(ec)))
}
