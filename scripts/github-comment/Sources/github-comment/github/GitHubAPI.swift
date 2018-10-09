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

private let apiUrlBase = "https://api.github.com/"

// API methods for GitHub

extension GitHub {
  /**
   Fetches all pages of a paginated query.

   @param urlAsString An API url to request. Should be relative to https://api.github.com/
   @param didSucceed Invoked with each page's data, parsed as json, as it returns.
                     Return true to continue paginating.
                     Return false to stop paginating.
   */
  func getAll(startingFrom urlAsString: String, didSucceed: (Any) -> Bool) {
    var nextUrl = URL(string: apiUrlBase + urlAsString)
    while let url = nextUrl {
      let request = authenticated(request: URLRequest(url: url))

      let results = synchronousRequestJson(with: request)
      if results.response?.statusCode == 200 {
        if let json = results.json {
          if !didSucceed(json) {
            break
          }
        }
      } else {
        if let error = results.error {
          print("Error: \(error.localizedDescription)")
        }
        exit(1)
      }

      guard let links = results.response?.allHeaderFields["Link"] as? String,
        let nextLink = links.components(separatedBy: ",").filter({ $0.contains("rel=\"next\"") }).first,
        let nextUrlAsString = nextLink.components(separatedBy: ";").first?
          .trimmingCharacters(in: .init(charactersIn: " "))
          .trimmingCharacters(in: .init(charactersIn: "<>")) else {
            break
      }
      nextUrl = URL(string: nextUrlAsString)
    }
  }

  /**
   Fetches a single object.

   @param urlAsString An API url to request. Should be relative to https://api.github.com/
   @param didSucceed Invoked with the response data parsed as json.
   */
  func get<T: GitHubObject>(from urlAsString: String) -> T? {
    guard let url = URL(string: apiUrlBase + urlAsString) else {
      return nil
    }
    let request = authenticated(request: URLRequest(url: url))
    let results = synchronousRequestJson(with: request)
    if results.response?.statusCode == 200 {
      if let jsonResult = results.json {
        guard let json = jsonResult as? T.JsonFormat else {
          return nil
        }
        return T(json: json)
      }

    } else {
      if let error = results.error {
        print("Error: \(error.localizedDescription)")
      }
      exit(1)
    }
    return nil
  }

  /**
   Fetches a string.

   @param urlAsString An API url to request. Should be relative to https://api.github.com/
   @param additionalHeaders Optional additional request headers.
   */
  func get(from urlAsString: String, additionalHeaders: [String: String]? = nil) -> String? {
    guard let url = URL(string: apiUrlBase + urlAsString) else {
      return nil
    }
    var request = authenticated(request: URLRequest(url: url))
    if let additionalHeaders = additionalHeaders {
      for (field, value) in additionalHeaders {
        request.addValue(value, forHTTPHeaderField: field)
      }
    }
    let result = synchronousRequest(with: request)
    if result.response?.statusCode == 200, let data = result.data {
      return String(data: data, encoding: .utf8)

    } else {
      if let error = result.error {
        print("Error: \(error.localizedDescription)")
      }
      exit(1)
    }
    return nil
  }

  /**
   Patches a single object.

   @param urlAsString An API url to request. Should be relative to https://api.github.com/
   @param json The json data to send.
   @returns The parsed json object.
   */
  @discardableResult func patch(to urlAsString: String, json: Any) -> Any? {
    return mutate(urlAsString: urlAsString, method: "PATCH", json: json)
  }

  /**
   Posts a single object.

   @param urlAsString An API url to request. Should be relative to https://api.github.com/
   @param json The json data to send.
   @returns The parsed json object.
   */
  @discardableResult func post(to urlAsString: String, json: Any) -> Any? {
    return mutate(urlAsString: urlAsString, method: "POST", json: json)
  }

  /**
   Deletes a single object.

   @param urlAsString An API url to request. Should be relative to https://api.github.com/
   @param didSucceed Invoked with the response data parsed as json.
   @returns The parsed json object.
   */
  @discardableResult func delete(at urlAsString: String) -> Any? {
    return mutate(urlAsString: urlAsString, method: "DELETE", json: nil)
  }

  private func mutate(urlAsString: String, method: String, json: Any?) -> Any? {
    sleep(1) // Avoid hitting abuse rate limits
    guard let url = URL(string: apiUrlBase + urlAsString) else {
      return nil
    }
    var request = authenticated(request: URLRequest(url: url))
    request.httpMethod = method
    if let json = json {
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      do {
        request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
      } catch {
        print("Failed to encode json.")
        exit(1)
      }
    }

    let results = synchronousRequestJson(with: request)

    if results.response?.statusCode == 200
      || results.response?.statusCode == 201
      || results.response?.statusCode == 204 {
      if let json = results.json {
        return json
      }
    } else {
      if let error = results.error {
        print("Error: \(error.localizedDescription)")
      }
      exit(1)
    }
    return nil
  }

  private func authenticated(request: URLRequest) -> URLRequest {
    var request = request
    request.addValue("token \(token)", forHTTPHeaderField: "Authorization")
    return request
  }
}

