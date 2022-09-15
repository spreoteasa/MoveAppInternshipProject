//
//  HalfSheetModal.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 14.09.2022.
//

import SwiftUI

struct HalfSheetModal: View {
    @State var showSheet = false
    var body: some View {
        
        NavigationView {
            Button {
                print("ha?")
            }label: {
                Text("Present sheet")
            }
            .halfSheet(showSheet: $showSheet, sheetView: {
                Text("ksjdnfksnfksn")
            }, onEnd: {print("Dismissed")})
        }

        
    }
}

struct HalfSheetModal_Previews: PreviewProvider {
    static var previews: some View {
        HalfSheetModal()
    }
}

extension View {
    
    func halfSheet<SheetView: View>(showSheet: Binding<Bool>, @ViewBuilder sheetView: @escaping ()->SheetView, onEnd: @escaping ()->Void) -> some View {
        
        return self
            .background(
                HalfSheetHelper(sheetView: sheetView(), onEnd: onEnd, showSheet: showSheet)
            )
    }
}

struct HalfSheetHelper<SheetView: View>: UIViewControllerRepresentable {
    
    var sheetView: SheetView
    let onEnd: ()->Void
    @Binding var showSheet: Bool
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    let controller = UIViewController()
    
    func makeUIViewController(context: Context) -> UIViewController {
        controller.view.backgroundColor = .clear
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if showSheet {
            let sheetController = CustomHostingController(rootView: sheetView)
            sheetController.presentationController?.delegate = context.coordinator
            uiViewController.present(sheetController, animated: true)
        } else {
            uiViewController.dismiss(animated: true)
        }
    }
    
    class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        
        var parent: HalfSheetHelper
        
        init(parent: HalfSheetHelper) {
            self.parent = parent
        }
        
        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            parent.onEnd()
        }
    }
}

class CustomHostingController<Content: View>: UIHostingController<Content> {
    
    override func viewDidLoad() {
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium(), .large()]
            presentationController.prefersGrabberVisible = true
        }
    }
}