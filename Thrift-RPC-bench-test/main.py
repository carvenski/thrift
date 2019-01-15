from PCMonitorThriftService.PCMonitorElementThriftService import Client
from PCMonitorThriftService.ttypes import PCMonitorElementUnitThriftModel

from thrift import Thrift
from thrift.transport import TSocket
from thrift.transport import TTransport
from thrift.protocol import TCompactProtocol

import sys
import threading
import uuid
from Queue import Queue
import time


"""
this is a RPC bench test for gosun java PCMonitorThriftService project.
usage:
    python main.py 10000 2 
    (just like apache ab benchmark command: ab -n 10000 -c 2)
"""
def test_rpc(q, p):
    transport = TTransport.TFramedTransport(TSocket.TSocket('172.17.0.19', 9935))
    protocol = TCompactProtocol.TCompactProtocol(transport)    
    client = Client(protocol)
    transport.open()

    def insert(n):
        try:
            unit = PCMonitorElementUnitThriftModel(
                str(n), 
                1L, 1, "x", 1, 1, 
                str(uuid.uuid1()), 
                "x", "x", 1, 1, 1, 1, "x", 1, "x", 1, 1, 1, 1, 1, 1, 1, 1, 1, "x", 1, 1, "x", "x", 1)
            res = client.putPCMonitorElement(1, 1L, unit)
            return res
        except:
            return None

    while not q.empty():
        r = insert(q.get())
        if r:
            p.put(True)
        else:
            p.put(None)
        print("finish 1 request...with q,p size=(%s, %s)" % (q.qsize(), p.qsize()))

        
    transport.close()
    print("=> 1 thread has ended...with q,p size=(%s, %s)" % (q.qsize(), p.qsize()) )


def main(args):
    if len(args) != 3:        
        print("must provide 2 args: requests & concurrency number !")
    
    requests = int(args[-2])
    concurrency = int(args[-1])

    q = Queue(requests)
    p = Queue(requests)
    for i in range(requests):
        q.put(i)

    start = time.time()
    print("=> start time= %s" % start)
    l = []
    for _ in range(concurrency):
        t = threading.Thread(target=test_rpc, args=(q, p) )
        t.start()
        l.append(t)
    for th in l:
        th.join()

    end = time.time()
    print("=> end time= %s" % end)
    all_time = end - start
    print("====> all time is [%s] seconds." % all_time)
    
    fail = 0
    while not p.empty():
        if not p.get():
            fail += 1
    print("--> failed requests is %s" % fail)

    print("="*50)
    print("==> RPC test with: requests= %s & concurrency= %s" % (requests, concurrency))
    print("==> RPC QPS = %s requests/s" % (float(requests)/all_time) )
    print("="*50)


raw_input("please enter any key to start......")
main(sys.argv)



