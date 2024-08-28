//
//  PostSearchWebView.swift
//  Baobab
//
//  Created by 이정훈 on 5/24/24.
//

import WebKit
import SwiftUI

struct PostSearchWebView<T: PostSearchable>: UIViewRepresentable {
    @EnvironmentObject private var viewModel: T
    @Binding var isShowingDetailAddressForm: Bool
    @Binding var isProgress: Bool
    
    func makeUIView(context: Context) -> some UIView {
        guard let url = URL(string: "https://fx-baobab.github.io/DaumKakao_Postcode_Web/") else {
            return WKWebView()
        }
        
        let userContentController = WKUserContentController()
        userContentController.add(context.coordinator, name: "callBackHandler")
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad))
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}

extension PostSearchWebView {
    final class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        private var parent: PostSearchWebView
        
        init(parent: PostSearchWebView) {
            self.parent = parent
        }
        
        //웹 페이지 로딩이 끝났을때 호출되는 delegate method
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isProgress.toggle()
            print(parent.isProgress)
        }
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            guard let data = message.body as? [String: String] else {
                return
            }
            
            if let address = data["roadAddress"] {
                parent.viewModel.searchedAddress = address
            }
            
            if let postcode = data["zonecode"] {
                parent.viewModel.searchedPostCode = postcode
            }
            
            parent.isShowingDetailAddressForm.toggle()
        }
    }
}

#Preview {
    PostSearchWebView<ReceivingViewModel>(isShowingDetailAddressForm: .constant(false),
                      isProgress: .constant(false))
    .environmentObject(AppDI.shared.makeReceivingViewModel())
}
