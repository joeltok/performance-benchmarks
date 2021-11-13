package com.benchmarks.camundaservicetasks.bpmnservlet;

import org.camunda.bpm.engine.delegate.BpmnError;

import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;

/**
 * This is an easy adapter implementation
 * illustrating how a Java Delegate can be used
 * from within a BPMN 2.0 Service Task.
 */
public class Basic implements JavaDelegate {

	public void execute(DelegateExecution execution) throws Exception {
		int summed = 1 + 1; 		
  }

}
