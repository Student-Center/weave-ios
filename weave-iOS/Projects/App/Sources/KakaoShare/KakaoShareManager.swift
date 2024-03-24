//
//  KakaoShareManager.swift
//  weave-ios
//
//  Created by Jisu Kim on 3/24/24.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKShare
import KakaoSDKTemplate
import SafariServices

class KakaoShareManager {
    var safariViewController : SFSafariViewController? // to keep instance

    let title = "[WEAVE] 친구야 이 팀 어때?"
    let description = "피드 메시지 예제"

    static func getMeetingTeamShareMessage(teamId: String) -> Data {
        return """
                {
                    "object_type": "feed",
                    "content": {
                        "title": "[WEAVE] 친구야 이 팀 어때?",
                        "image_url": "\(SecretKey.serverResourcePath)/share_image.png",
                        "link": {
                            "mobile_web_url": "https://weave-server-dev-bucket.s3.ap-northeast-2.amazonaws.com/resource/share_image.png",
                            "web_url": "https://weave-server-dev-bucket.s3.ap-northeast-2.amazonaws.com/resource/share_image.png"
                        },
                    },
                    "buttons": [
                        {
                            "title": "팀 상세보기",
                            "link": {
                                "ios_execution_params": "type=vteam&teamId=\(teamId)",
                                "web_url": "https://developers.kakao.com"
                            }
                        }
                    ]
                }
                """
                .data(using: .utf8)!
    }
    
    static func shareMessage(with data: Data) {
        guard let templatable = try? SdkJSONDecoder.custom.decode(FeedTemplate.self, from: data) else {
            return
        }
        // 카카오톡 설치여부 확인
        if ShareApi.isKakaoTalkSharingAvailable() {
            // 카카오톡으로 카카오톡 공유 가능
            // templatable은 메시지 만들기 항목 참고
            ShareApi.shared.shareDefault(templatable: templatable) {(sharingResult, error) in
                if let error = error {
                    print(error)
                } else {
                    print("shareDefault() success.")
                    
                    if let sharingResult = sharingResult {
                        UIApplication.shared.open(
                            sharingResult.url,
                            options: [:], completionHandler: nil
                        )
                    }
                }
            }
        } else {
            // 카카오톡 미설치: 웹 공유 사용 권장
            // Custom WebView 또는 디폴트 브라우져 사용 가능
            // 웹 공유 예시 코드
//            if let url = ShareApi.shared.makeDefaultUrl(templatable: templatable) {
//                self.safariViewController = SFSafariViewController(url: url)
//                self.safariViewController?.modalTransitionStyle = .crossDissolve
//                self.safariViewController?.modalPresentationStyle = .overCurrentContext
//                self.present(self.safariViewController!, animated: true) {
//                    print("웹 present success")
//                }
//            }
        }
    }
}
