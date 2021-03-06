package com.uppaal.chiporiginal;

import java.util.concurrent.TimeUnit;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.Condition;

import com.uppaal.dummy.WriteModelSimInput;
import com.uppaal.tron.Reporter;
import com.uppaal.tron.VirtualThread;
import com.uppaal.tron.VirtualLock;
import com.uppaal.tron.VirtualCondition;

public class Chip extends VirtualThread implements ChipInterface
{
    private enum Loc { wait, send, Idle, Done }
    private Loc location;
    
    Reporter reporter = null;

    Lock lock = null;
    Condition cond = null;
    boolean started = false;
    ChipListener listener = null;

    public Chip(int mutant)
    {
	super("Chip");
	location = Loc.wait;
    }

//    public void setReporter(Reporter r) 
//    {
//	reporter = r;
//    }
    
    public void setChipListener(ChipListener listener) 
    {
	this.listener = listener;
    }

    public synchronized void waitForStart() throws InterruptedException
    { 
	while (!started) wait(); 
    }

    public void run() {
	try { execute(); }
	catch (InterruptedException e){}
	System.out.println("Chip interrupted in "+location);
	reporter.disconnect();
	lock.unlock();
    }

    protected void execute() throws InterruptedException
    {
	lock = new VirtualLock("DummyLock");
	cond = lock.newCondition();
	lock.lock();
	// notify that dummy is ready:
	synchronized (this) { started = true; notifyAll(); }

	while (started) {
	    switch (location) {
	    case wait:
		cond.await();
		break;
	    case Idle:
		if (!cond.await(1000, TimeUnit.MILLISECONDS)) {
		    listener.reportMyOutput();
		    location = Loc.Done;
		} // else state is already updated
		break;
	    }
	}
    } 
    
//    protected void execute() throws InterruptedException
//    {
//    
//    boolean stillWaiting;
//	lock = new VirtualLock("ChipLock");
//	cond = lock.newCondition();
//	lock.lock();
//	// notify that chip is ready:
//	synchronized (this) { started = true; notifyAll(); }
//
////	while (started) {
////	    switch (location) {
////	    case Idle:
////		cond.await();
////		break;
////	    case Busy:
////		if (!cond.await(1000, TimeUnit.MILLISECONDS)) {
////		    listener.reportMyOutput();
////		    location = Loc.Idle;
////		} // else state is already updated
////		break;
////	    }
////	}
//	
//	System.out.println("Chip Init: "+location);
//	while (true) {
//	    System.out.println("Chip State: "+location);
//	    switch (location) {
//	    case wait:
//	    	if (!cond.await(1000, TimeUnit.MILLISECONDS)) {
//			    listener.reportMyOutput();
//			    location = Loc.send;
//			} // else state is already updated
//			break;
//		    
//	    case send:
//		System.out.println("Chip before wait: "+location);
//		stillWaiting=cond.await(1000, TimeUnit.MILLISECONDS);
//		System.out.println("Chip after cond.wait: "+location);
//		if(stillWaiting){
//		    //the light was touched before time out
//		    //so just wait for a fresh interval
//		} else {
//		    if (location == Loc.send) {
//			    listener.reportMyOutput();
//			    location = Loc.wait;
//		    }
//		}
//		break;
//	    }
//	}
//	
//    }

    public void handleMyInput1(int sourceNode, int destinationNode) throws InterruptedException
    {
    	if (!started) waitForStart();
	lock.lock();
	switch (location) {
	case wait:
	    location = Loc.send;
	    WriteModelSimInput.writeFile(sourceNode, destinationNode);
	    cond.signalAll();
	    break;
	
	case send:
	    location = Loc.wait;
	    WriteModelSimInput.writeFile(sourceNode, destinationNode);
	    cond.signalAll();
	    break;    
	    
	}
	lock.unlock();
    }

    public void handleMyInput2(int sourceNode, int destinationNode) throws InterruptedException
    {
    	if (!started) waitForStart();
	lock.lock();
	switch (location) {
	case wait:
	    location = Loc.send;
	    WriteModelSimInput.writeFile(sourceNode, destinationNode);
	    cond.signalAll();
	    break;
	
	case send:
	    location = Loc.wait;
	    WriteModelSimInput.writeFile(sourceNode, destinationNode);
	    cond.signalAll();
	    break;
	    
	}
	lock.unlock();
    }

	public void handleMyInput3(int sourceNode, int destinationNode) throws InterruptedException {
		if (!started) waitForStart();
	    	lock.lock();
	    	switch (location) {
	    	case wait:
	    	    location = Loc.send;
	    	    WriteModelSimInput.writeFile(sourceNode, destinationNode);
	    	    cond.signalAll();
	    	    break;
	    	
	    	case send:
	    	    location = Loc.wait;
	    	    WriteModelSimInput.writeFile(sourceNode, destinationNode);
	    	    cond.signalAll();
	    	    break;
	    	    
	    	}
	    	lock.unlock();
	        }

	public void handleMyInput4(int sourceNode, int destinationNode) throws InterruptedException {
		if (!started) waitForStart();
    	lock.lock();
    	switch (location) {
    	case wait:
    	    location = Loc.send;
    	    WriteModelSimInput.writeFile(sourceNode, destinationNode);
    	    cond.signalAll();
    	    break;
    	
    	case send:
    	    location = Loc.wait;
    	    WriteModelSimInput.writeFile(sourceNode, destinationNode);
    	    cond.signalAll();
    	    break;
    	    
    	}
    	lock.unlock();
        }

	public void setReporter(Reporter r) {
		// TODO Auto-generated method stub
		
	}

}
