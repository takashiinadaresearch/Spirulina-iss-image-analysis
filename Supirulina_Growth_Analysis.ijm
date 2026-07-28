// スピルリナ専用・GチャンネルMoments（Results強制表示版）

dir = getDirectory("① 解析したい画像が入った『フォルダ』を選択してください");
list = getFileList(dir);

// 共通のROIファイルを1つだけ読み込む
roi_path = File.openDialog("② このフォルダで使い回す『共通のROIファイル(.roi)』を選択してください");
if (roiManager("count") > 0) {
    roiManager("Delete"); // 古い枠をリセット
}
roiManager("Open", roi_path); // 1つだけの共通枠をセット

// 画面を非表示にして爆速処理
setBatchMode(true); 

for (i = 0; i < list.length; i++) {
    if (endsWith(list[i], ".tif") || endsWith(list[i], ".tiff")) {
        
        open(dir + list[i]);
        
        // 1. 画像をR, G, Bに分解する
        run("Split Channels");
        
        // 2. 開いているすべてのウィンドウから、緑チャンネルのIDを自動取得する
        images = getList("image.titles");
        gWindow = "";
        for (j = 0; j < images.length; j++) {
            if (startsWith(images[j], "G-") || indexOf(images[j], "green") >= 0) {
                gWindow = images[j];
            } else {
                selectWindow(images[j]);
                close();
            }
        }
        
        // 3. 確実に特定した「Gチャンネル」のウィンドウを選択する
        selectWindow(gWindow);
        
        // 4. Moments法を使って自動二値化
        run("Auto Threshold", "method=Moments black");
        
        // 5. ノイズ除去（2回ずつ）
        run("Dilate");
        run("Dilate");
        run("Erode");
        run("Erode");
        
        // 6. 共通ROI枠（0番目）を重ねて測定
        roiManager("Select", 0);
        run("Measure");
        
        // 処理が終わった画像を閉じて次へ
        close();
    }
}

// 【重要】非表示モードを解除して、画面を一度リフレッシュする
setBatchMode(false);
updateResults(); // データを強制書き込み

// 【ここが対策！】もしResultsウィンドウが存在すれば、強制的に最前面に出す
if (isOpen("Results")) {
    selectWindow("Results");
}

showMessage("解析完了！", "すべての解析が終了しました。Results画面をご確認ください！");