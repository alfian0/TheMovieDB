//
//  PerformanceManager.swift
//  TheMovieDB
//
//  Created by alfian on 02/08/24.
//

import Foundation
import FirebasePerformance

class PerformanceManager {
  static let shared = PerformanceManager()
  private init() {}

  private var traces: [String: Trace] = [:]
  private var metrics: [String: HTTPMetric] = [:]

  func startTrace(name: String) {
    let trace = Performance.startTrace(name: name)
    traces[name] = trace
  }

  func setValue(name: String, value: String, forAttribute: String) {
    guard let trace = traces[name] else { return }
    trace.setValue(value, forAttribute: forAttribute)
  }

  func stopTrace(name: String) {
    guard let trace = traces[name] else { return }
    trace.stop()
    traces.removeValue(forKey: name)
  }

  func startTrace(url: URL, httpMethod: HTTPMethod) {
    let metric = HTTPMetric(url: url, httpMethod: httpMethod)
    metric?.start()
    metrics[url.absoluteString] = metric
  }

  func stopTrace(url: URL) {
    guard let metric = metrics[url.absoluteString] else { return }
    metric.stop()
  }

  func setValue(url: URL, value: String, forAttribute: String) {
    guard let metric = metrics[url.absoluteString] else { return }
    metric.setValue(value, forAttribute: forAttribute)
  }

  func setResponseCode(url: URL, responseCode: Int) {
    guard let metric = metrics[url.absoluteString] else { return }
    metric.responseCode = responseCode
  }
}
