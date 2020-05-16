#!/usr/bin/env python
# -*- coding: utf-8 -*-
##
# @file     queue_onoff_traffic.py
# @author   Kyeong Soo (Joseph) Kim <kyeongsoo.kim@gmail.com>
# @date     2018-11-23
#
# @brief    Simulate a queueing system with an on-off packet generator.
#


import argparse
import numpy as np
import simpy


class Packet(object):
    """
    Parameters:
    - ctime: packet creation time
    - size: packet size in bytes
    """
    def __init__(self, ctime, size):
        self.ctime = ctime
        self.size = size


class OnoffPacketGenerator(object):
    """Generate fixed-size packets back to back based on on-off status.

    Parameters:
    - env: simpy.Environment
    - pkt_size: packet size in bytes
    - pkt_ia_time: packet inter arrival time in second
    - on_period: ON period in second
    - off_period: OFF period in second
    """
    def __init__(self, env, pkt_size, pkt_ia_time, on_period, off_period,
                 trace=False):
        self.env = env
        self.pkt_size = pkt_size
        self.pkt_ia_time = pkt_ia_time
        self.on_period = on_period
        self.off_period = off_period
        self.trace = trace
        self.out = None
        self.on = True
        self.gen_permission = simpy.Resource(env, capacity=1)
        self.action = env.process(self.run())  # start the run process when an instance is created

    def run(self):
        env.process(self.update_status())
        while True:
            with self.gen_permission.request() as req:
                yield req
                p = Packet(self.env.now, self.pkt_size)
                self.out.put(p)
                if self.trace:
                    print("t={0:.4E} [s]: packet generated with size={1:.4E} [B]".format(self.env.now, self.pkt_size))
            yield self.env.timeout(self.pkt_ia_time)

    def update_status(self):
        while True:
            now = self.env.now
            if self.on:
                if self.trace:
                    print("t={:.4E} [s]: OFF->ON".format(now))
                yield env.timeout(self.on_period)
            else:
                if self.trace:
                    print("t={:.4E} [s]: ON->OFF".format(now))
                req = self.gen_permission.request()
                yield env.timeout(self.off_period)
                self.gen_permission.release(req)
            self.on = not self.on  # toggle the status


class FifoQueue(object):

    """Receive, process, and send out packets.

    Parameters:
    - env : simpy.Environment
    """
    def __init__(self, env, pkt_ia_time, trace=False):
        self.trace = trace
        self.pkt_ia_time = pkt_ia_time
        self.store = simpy.Store(env)
        self.env = env
        self.out = None
        self.action = env.process(self.run())
        self.token_capacity = 5000
        self.token_rate = 10485760
        self.token_current = 0
        self.wait_times=[]
    def run(self,):
        while True:
            msg = (yield self.store.get())
            # TODO: Implement packet processing here.
            now = self.env.now
            yield self.env.timeout(self.pkt_ia_time/2)
            if msg.size <= self.token_current:
                self.token_current = self.token_current - msg.size + msg.size
                self.out.put(msg)
                self.wait_times.append(self.env.now - now)
                wait_time = self.env.now - now
                print("t={0:.4E} [s]: packet wait for time={1:.4E} [s]".format(self.env.now, wait_time))
            else:
                temp = self.token_current + msg.size
                self.token_current = min(temp, self.token_capacity)
                yield self.env.timeout(self.pkt_ia_time)
                self.wait_times.append(self.env.now - now)
                wait_time = self.env.now - now
                print("t={0:.4E} [s]: packet wait for time={1:.4E} [s]".format(self.env.now, wait_time))

    def put(self, pkt):
        self.store.put(pkt)



class PacketSink(object):
    """Receives packets and display delay information.

    Parameters:
    - env : simpy.Environment
    - trace: Boolean

    """
    def __init__(self, env, trace=False):
        self.store = simpy.Store(env)
        self.env = env
        self.trace = trace
        self.wait_times = []
        self.action = env.process(self.run())

    def run(self):
        while True:
            msg = (yield self.store.get())
            now = self.env.now
            self.wait_times.append(now - msg.ctime)
            delay = now - msg.ctime
            if self.trace:
                print("t={0:.4E} [s]: packet arrived with size={1:.4E} [B] delay={2:.4E} [s]".format(now, msg.size,
                                                                                                     delay))

    def put(self, pkt):
        self.store.put(pkt)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-S",
        "--pkt_size",
        help="packet size [byte]; default is 1000",
        default=1000,
        type=int)
    parser.add_argument(
        "-A",
        "--pkt_ia_time",
        help="packet interarrival time [second]; default is 0.1",
        default=0.0001,
        type=float)
    parser.add_argument(
        "--on_period",
        help="on period [second]; default is 1.0",
        default=0.001,
        type=float)
    parser.add_argument(
        "--off_period",
        help="off period [second]; default is 1.0",
        default=0.001,
        type=float)
    parser.add_argument(
        "-T",
        "--sim_time",
        help="time to end the simulation [second]; default is 10",
        default=0.005,
        type=float)
    parser.add_argument(
        "-R",
        "--random_seed",
        help="seed for random number generation; default is 1234",
        default=1234,
        type=int)
    parser.add_argument('--trace', dest='trace', action='store_true')
    parser.add_argument('--no-trace', dest='trace', action='store_false')
    parser.set_defaults(trace=True)
    args = parser.parse_args()

    # set variables using command-line arguments
    pkt_size = args.pkt_size
    pkt_ia_time = args.pkt_ia_time
    on_period = args.on_period
    off_period = args.off_period
    sim_time = args.sim_time
    random_seed = args.random_seed
    trace = args.trace

    env = simpy.Environment()
    pg = OnoffPacketGenerator(env, pkt_size, pkt_ia_time, on_period, off_period,
                              trace)
    fifo = FifoQueue(env, pkt_ia_time, trace)  # TODO: implemente FifoQueue class
    ps = PacketSink(env, trace)
    pg.out = fifo
    fifo.out = ps
    env.run(until=sim_time)
    print("Average delay time = {:.4E} [s]\n".format(np.mean(ps.wait_times)))
    print("Average waiting time = {:.4E} [s]\n".format(np.mean(fifo.wait_times)))
