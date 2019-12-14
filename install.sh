#!/usr/bin/env bash

## 첫번째로 Homebrew가 설치되었는지 확인하고, 되어있지 않다면 Homebrew를 설치합니다.
if ! which brew
then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

## 필요한 경우에만 sudo 를 사용하기 위해 루트 패스워드를 입력 받습니다.
read -r -s -p "[sudo] sudo password for $(whoami):" pass

## Brewfile을 설치합니다.
brew bundle --file=./Brewfile

## cask 로 설치한 일부 애플리케이션을 바로 실행하기 위해 다운로드 된 파일에 대한 격리 속성을 제거합니다. 
echo "$pass" | sudo -S xattr -dr com.apple.quarantine /Applications/iTerm.app
echo "$pass" | sudo -S xattr -dr com.apple.quarantine /Applications/Google\ Chrome.app
echo "$pass" | sudo -S xattr -dr com.apple.quarantine /Applications/Zeplin.app
echo "$pass" | sudo -S xattr -dr com.apple.quarantine /Applications/Slack.app

# Xcode 설치 마무리
# Xcode command-line tools를 설치
# 명령어를 통해 Xcode의 라이센스를 동의합니다.
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
sudo xcodebuild -license accept

# 플러터 설치에 필요한 패키지
# brew update
# brew install --HEAD libimobiledevice
# brew install ideviceinstaller ios-deploy cocoapods
pod setup

## 모든 작업이 성공적으로 되었다는 가정 하에 축하 메세지를 출력!
printf '\n\n🎉 Congrat! Your mac has been set up successfully for working with Andrew Team!\n'