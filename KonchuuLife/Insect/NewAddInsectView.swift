//
//  NewAddInsectView.swift
//  KonchuuLife
//
//  Created by 越智三四郎 on 2024/11/02.
//

import SwiftUI
import PhotosUI
import AVFoundation

struct HideKeyboardOnTapModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
    }
}

extension View {
    func hideKeyboardOnTap() -> some View {
        self.modifier(HideKeyboardOnTapModifier())
    }
}

struct NewAddInsectView: View {
    @StateObject var viewModel: NewAddInsectViewModel
    @ObservedObject var myInsectViewModel: MyInsectViewModel
    @State private var navigateToMainTab = false
    @State private var showingPhotoLibraryPicker = false
    @State private var showingCameraPicker = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    let insectSizes = [
        "",
        "1cm〜3cm",
            "4cm〜6cm",
            "7cm〜9cm",
            "10cm〜12cm",
            "13cm〜15cm",
            "16cm以上"
    ]
    @State private var selectType = ""
    let insectType = [
        "",
        "不明",
        "バッタ",
        "カマキリ",
        "クワガタ",
        "トンボ"
    ]

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button(action: {
                        navigateToMainTab = true
                    }) {
                        Text("×")
                            .font(.system(size: 30, weight: .medium, design: .default))
                            .padding()
                            .background(Color.clear)
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 10)
                    Spacer().frame(width: 84)
                    Text("昆虫を追加")
                        .font(.title)
                    Spacer()
                }
                .padding(.top, 0)
                Spacer()
                HStack {
                    if let selectedImage = viewModel.image {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 130)
                    } else {
                        Rectangle()
                                .stroke(lineWidth: 2)
                                .frame(width: 320, height: 130)
                                .foregroundColor(.gray)
                                .background(Color.gray.opacity(0.2))
                    }

                    VStack {
                        Button(action: {
                            checkCameraAccess()
                        }) {
                            Image(systemName: "camera")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.gray)
                        }
                        .padding(.bottom, 80)
                        Button(action: {
                            checkPhotoLibraryAccess()
                        }) {
                            Image(systemName: "photo.on.rectangle.angled")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.top, 10)
                Spacer().frame(height: 30)
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("昆虫の名前")
                        TextField("名前を入力", text: $viewModel.name)
                            .textFieldStyle(PlainTextFieldStyle())
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.black),
                                alignment: .bottom
                            )
                    }.padding(.leading, 20)
                        .padding(.trailing, 10)
                    VStack(alignment: .leading) {
                        Text("昆虫のサイズ")
                        HStack {
                            Picker("サイズを選択", selection: $viewModel.size) {
                                ForEach(insectSizes, id: \.self) { size in
                                    Text(size.isEmpty ? "サイズを選択" : size)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .pickerStyle(MenuPickerStyle())
                        }
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.black),
                            alignment: .bottom
                        )
                    }.padding(.leading, 20)
                        .padding(.trailing, 10)
                    VStack(alignment: .leading) {
                        Text("昆虫のタイプ")
                        HStack {
                            Picker(selectType.isEmpty ? "タイプを選択" : selectType, selection: $selectType) {
                                ForEach(insectType, id: \.self) { type in
                                    Text(type.isEmpty ? "タイプを選択" : type)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .pickerStyle(MenuPickerStyle())
                        }
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.black),
                            alignment: .bottom
                        )
                    }.padding(.leading, 20)
                        .padding(.trailing, 10)

                    VStack(alignment: .leading) {
                        Text("メモ")
                        TextEditor(text: .constant(""))
                            .frame(height: 100)
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.black),
                                alignment: .bottom
                            )
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 10)
                    HStack {
                        Spacer()
                        Button("確定") {
                            viewModel.saveInsect(to: myInsectViewModel)
                            navigateToMainTab = true
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .frame(width: 200,height: 50)
                        .cornerRadius(20.0)
                        Spacer()
                    }
                    .padding(.top, 20)
                }
                // カメラ用のシート
                .sheet(isPresented: $showingCameraPicker) {
                    ImagePickerView(selectedImage: $viewModel.image, sourceType: .camera)
                }
                // フォトライブラリ用のシート
                .sheet(isPresented: $showingPhotoLibraryPicker) {
                    ImagePickerView(selectedImage: $viewModel.image, sourceType: .photoLibrary)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("アクセス許可が必要です"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                .navigationBarHidden(true)
                .navigationDestination(isPresented: $navigateToMainTab) {
                    MainTabView()
                }
            }
        }
        .hideKeyboardOnTap()
    }

    func checkCameraAccess() {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)

        switch cameraAuthorizationStatus {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        showingCameraPicker = true
                    }
                } else {
                    alertMessage = "カメラへのアクセスが許可されていません。設定からアクセスを許可してください。"
                    showAlert = true
                }
            }
        case .authorized:
            showingCameraPicker = true
        case .denied, .restricted:
            alertMessage = "カメラへのアクセスが許可されていません。設定からアクセスを許可してください。"
            showAlert = true
        @unknown default:
            break
        }
    }

    func checkPhotoLibraryAccess() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()

        switch photoAuthorizationStatus {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized || status == .limited {
                    DispatchQueue.main.async {
                        showingPhotoLibraryPicker = true
                    }
                } else {
                    alertMessage = "写真ライブラリへのアクセスが許可されていません。設定からアクセスを許可してください。"
                    showAlert = true
                }
            }
        case .authorized, .limited:
            showingPhotoLibraryPicker = true
        case .denied, .restricted:
            alertMessage = "写真ライブラリへのアクセスが許可されていません。設定からアクセスを許可してください。"
            showAlert = true
        @unknown default:
            break
        }
    }
}
