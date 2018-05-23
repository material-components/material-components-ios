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

extension GitHub {
  struct Comment: GitHubObject {
    typealias JsonFormat = [String: Any]
    init(json: JsonFormat) {
      self.json = json
    }
    private let json: JsonFormat

    var id: Int? { get { return json["id"] as? Int } }
    var body: String? { get { return json["body"] as? String } }
    var user: User? {
      get {
        guard let user = json["user"] as? User.JsonFormat else {
          return nil
        }
        return User(json: user)
      }
    }
  }

  struct CommentList: GitHubObject {
    typealias JsonFormat = [Comment.JsonFormat]
    init(json: JsonFormat) {
      self.json = json
    }
    private let json: JsonFormat

    var comments: [Comment]? {
      get {
        return json.map { Comment(json: $0) }
      }
    }
  }
}
