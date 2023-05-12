//
//  ConquestModel.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 12/05/23.
//

import SwiftUI

/// - Enabling Popover for iOS
extension View{
    @available(iOS 14,*)
    @ViewBuilder
    func iOSPopover<Content: View>(showModalConquest: Binding<Bool>,arrowDirection: UIPopoverArrowDirection,@ViewBuilder content: @escaping ()->Content)->some View{
        self
            .background {
                PopOverController(showModalConquest: showModalConquest, arrowDirection: arrowDirection, content: content())
            }
    }
}

/// - Popover Helper
fileprivate struct PopOverController<Content: View>: UIViewControllerRepresentable{
    @Binding var showModalConquest: Bool
    var arrowDirection: UIPopoverArrowDirection
    var content: Content
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        controller.view.backgroundColor = .clear
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if let hostingController = uiViewController.presentedViewController as? CustomHostingView<Content>{
            /// - Close View, if it's toggled Back
            if !showModalConquest {
                /// - Closing Popover
                uiViewController.dismiss(animated: true)
            } else {
                hostingController.rootView = content
                /// - Updating View Size when it's Update
                /// - Or You can define your own size in SwiftUI View
                hostingController.preferredContentSize = hostingController.view.intrinsicContentSize
                /// - If you don't want animation
                // UIView.animate(withDuration: 0) {
                //    hostingController.preferredContentSize = hostingController.view.intrinsicContentSize
                // }
            }
        }else{
            if showModalConquest{
                /// - Presenting Popover
                let controller = CustomHostingView(rootView: content)
                controller.view.backgroundColor = .white
                controller.modalPresentationStyle = .popover
                controller.popoverPresentationController?.permittedArrowDirections = arrowDirection
                /// - Connecting Delegate
                controller.presentationController?.delegate = context.coordinator
                /// - We Need to Attach the Source View So that it will show Arrow At Correct Position
                controller.popoverPresentationController?.sourceView = uiViewController.view
                /// - Simply Presenting PopOver Controller
                uiViewController.present(controller, animated: true)
            }
        }
    }
    
    /// - Forcing it to show Popover using PresentationDelegate
    class Coordinator: NSObject,UIPopoverPresentationControllerDelegate{
        var parent: PopOverController
        init(parent: PopOverController) {
            self.parent = parent
        }
        
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }
        
        /// - Observing The status of the Popover
        /// - When it's dismissed updating the showModalConquest State
        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            parent.showModalConquest = false
        }
    }
}

/// - Custom Hosting Controller for Wrapping to it's SwiftUI View Size
fileprivate class CustomHostingView<Content: View>: UIHostingController<Content>{
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = view.intrinsicContentSize
    }
}


