/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import Foundation

typealias RequestResult = (data: Data?, response: HTTPURLResponse?, error: Error?)
typealias RequestJsonResult = (json: Any?, response: HTTPURLResponse?, error: Error?)

/**
 Makes a synchronous http request and returns the result as Data.
 */
func synchronousRequest(with request: URLRequest) -> RequestResult {
  let semaphore = DispatchSemaphore(value: 0)
  var result: RequestResult
  let task = URLSession.shared.dataTask(with: request) { data, response, error in
    result = (data, response as? HTTPURLResponse, error)
    semaphore.signal()
  }

  task.resume()
  _ = semaphore.wait(timeout: .distantFuture)

  return result
}

/**
 Makes a synchronous http request and returns the result parsed as JSON.
 */
func synchronousRequestJson(with request: URLRequest) -> RequestJsonResult {
  let result = synchronousRequest(with: request)

  guard let data = result.data else {
    return (nil, result.response, result.error)
  }

  do {
    let json = try JSONSerialization.jsonObject(with: data, options: [])
    return (json, result.response, result.error)
  } catch {
    return (nil, result.response, result.error)
  }
}

