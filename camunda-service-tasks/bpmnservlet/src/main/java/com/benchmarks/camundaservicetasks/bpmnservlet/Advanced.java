package com.benchmarks.camundaservicetasks.bpmnservlet;

import org.camunda.bpm.engine.delegate.BpmnError;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

/**
 * This is an easy adapter implementation
 * illustrating how a Java Delegate can be used
 * from within a BPMN 2.0 Service Task.
 */
public class Advanced implements JavaDelegate {

	private int factorial(int n) {
		if (n == 0) {
			return 1;
		}
		return n * factorial(n - 1);
	}
	
	public void execute(DelegateExecution execution) throws Exception {
		// run a loop of a factorial of 20 to simulate an intensive calculation
		for (int i = 0; i < 10000000; i++) {
			factorial(20);
		}	
  }

}
