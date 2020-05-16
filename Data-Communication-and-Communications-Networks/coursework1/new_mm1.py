#!/usr/bin/env python
# -*- coding: utf-8 -*-
##
# @file     new_mm1.py
# @author   Kyeong Soo (Joseph) Kim <kyeongsoo.kim@gmail.com>
# @date     2019-10-29
#
# @brief    Simulate M/M/1 queueing system
#
# @remarks  Copyright (C) 2019 Kyeong Soo (Joseph) Kim. All rights reserved.
#
# @remarks  This software is written and distributed under the GNU General
#           Public License Version 2 (http://www.gnu.org/licenses/gpl-2.0.html).
#           You must not remove this notice, or any other, from this software.
#

import argparse
import numpy as np
import random
import simpy
import sys


def source(env, mean_ia_time, mean_srv_time, server, delays, number, trace):
    """Generates packets with exponential interarrival time."""
    for i in range(number):
        ia_time = random.expovariate(1.0 / mean_ia_time)
        srv_time = random.expovariate(1.0 / mean_srv_time)
        pkt = packet(env, 'Packet-%d' % i, server, srv_time, delays, trace)
        env.process(pkt)
        yield env.timeout(ia_time)


def packet(env, name, server, service_time, delays, trace):
    """Requests a server, is served for a given service_time, and leaves the server."""
    arrv_time = env.now
    if trace:
        print("t={0:.4E}s: {1:s} arrived".format(arrv_time, name))

    with server.request() as request:
        yield request
        yield env.timeout(service_time)
        delay = env.now - arrv_time
        delays.append(delay)
        if trace:
            print("t={0:.4E}s: {1:s} served for {2:.4E}s".format(env.now, name, service_time))
            print("t={0:.4E}s: {1:s} delayed for {2:.4E}s".format(env.now, name, delay))


def run_simulation(num_servers, mean_ia_time, mean_srv_time, num_packets=10000, random_seed=1234, trace=True):
    """Runs a simulation and returns statistics."""
    if trace:
        print('M/M/1 queue\n')
    random.seed(random_seed)
    env = simpy.Environment()

    # start processes and run
    server = simpy.Resource(env, capacity=num_servers)
    delays = []
    env.process(source(env, mean_ia_time,
                       mean_srv_time, server, delays, number=num_packets, trace=trace))
    env.run()

    # return mean delay
    return np.mean(delays)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-M",
        "--num_servers",
        help="number of servers; default is 1",
        default=1,
        type=int)               # for extension to M/M/m
    parser.add_argument(
        "-A",
        "--arrival_rate",
        help="packet arrival rate [packets/s]; default is 1.0",
        default=1.0,
        type=float)
    parser.add_argument(
        "-S",
        "--service_rate",
        help="packet service rate [packets/s]; default is 10.0",
        default=0.1,
        type=float)
    parser.add_argument(
        "-N",
        "--num_packets",
        help="number of packets to generate; default is 10000",
        default=10000,
        type=int)
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
    num_servers = args.num_servers # for extension to M/M/m
    mean_ia_time = 1.0/args.arrival_rate
    mean_srv_time = 1.0/args.service_rate
    num_packets = args.num_packets
    random_seed = args.random_seed
    trace = args.trace

    # run a simulation
    mean_delay = run_simulation(num_servers, mean_ia_time, mean_srv_time,
                                                   num_packets, random_seed,
                                                   trace)

    # print arrival rate and mean delay
    print("{0:.4E}\t{1:.4E}".format(args.arrival_rate, mean_delay))
