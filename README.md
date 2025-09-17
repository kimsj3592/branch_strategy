# Git Branch Strategy Practice Project

이 프로젝트는 NestJS를 사용하여 Git 브랜치 전략과 rebase를 통한 선형 이력 관리를 연습하기 위한 프로젝트입니다.

## 🎯 목표

- Git 브랜치 전략 실습
- Rebase를 사용한 선형 이력 관리
- 다양한 Git 시나리오 연습

## 🌳 브랜치 전략

### 브랜치 구조

```
main (원천 소스)
├── feature/기능명 (기능 개발)
├── deploy/development/app (개발 환경 배포)
└── deploy/production/app (운영 환경 배포)
```

### 브랜치 역할

1. **main**: 원천 소스 브랜치
   - 안정적인 코드베이스
   - 모든 기능이 완성된 상태
   - 배포 가능한 상태 유지

2. **feature/기능명**: 기능 개발 브랜치
   - 새로운 기능 개발
   - main에서 분기하여 생성
   - 완료 후 main으로 병합

3. **deploy/development/app**: 개발 환경 배포 브랜치
   - 개발 서버에 배포되는 코드
   - main에서 분기하여 생성
   - 개발 환경 전용 설정 포함

4. **deploy/production/app**: 운영 환경 배포 브랜치
   - 운영 서버에 배포되는 코드
   - main에서 분기하여 생성
   - 운영 환경 전용 설정 포함

## 🔄 Git 워크플로우

### 1. 기능 개발 워크플로우

```bash
# 1. main 브랜치에서 최신 상태로 업데이트
git checkout main
git pull origin main

# 2. feature 브랜치 생성 및 전환
git checkout -b feature/user-authentication

# 3. 기능 개발 및 커밋
git add .
git commit -m "feat: add user authentication module"

# 4. main 브랜치로 rebase
git checkout main
git pull origin main
git checkout feature/user-authentication
git rebase main

# 5. main으로 병합 (fast-forward)
git checkout main
git merge feature/user-authentication

# 6. feature 브랜치 삭제
git branch -d feature/user-authentication
```

### 2. 배포 브랜치 업데이트 워크플로우

```bash
# 1. main에서 배포 브랜치로 rebase
git checkout deploy/development/app
git rebase main

# 2. 배포 브랜치에 환경별 설정 적용
# (환경별 설정 파일 수정)

# 3. 배포 브랜치 커밋
git add .
git commit -m "deploy: update development environment config"

# 4. 원격 저장소에 푸시
git push origin deploy/development/app
```

## 📚 연습 시나리오

### 시나리오 1: 기본 기능 개발
- 사용자 인증 모듈 추가
- API 엔드포인트 생성
- 데이터베이스 연동

### 시나리오 2: 충돌 해결
- 동시에 같은 파일을 수정하는 상황
- Rebase 중 충돌 발생 및 해결

### 시나리오 3: 배포 환경 설정
- 개발/운영 환경별 설정 분리
- 환경 변수 관리
- 배포 스크립트 작성

### 시나리오 4: Hotfix 처리
- 운영 환경에서 긴급 수정 필요
- Hotfix 브랜치 생성 및 처리

## 🛠️ 개발 환경 설정

### 필수 도구
- Node.js (v18 이상)
- Git
- VS Code (권장)

### 설치 및 실행

```bash
# 의존성 설치
npm install

# 개발 서버 실행
npm run start:dev

# 빌드
npm run build

# 프로덕션 실행
npm start
```

## 📖 학습 가이드

1. **기본 Git 명령어 숙지**
2. **Rebase vs Merge 이해**
3. **브랜치 전략 패턴 학습**
4. **충돌 해결 방법 연습**
5. **배포 프로세스 이해**

## 🎮 연습 방법

1. 각 시나리오별로 브랜치를 생성하고 작업
2. Rebase를 사용하여 선형 이력 유지
3. 충돌이 발생하는 상황을 의도적으로 만들어 해결 연습
4. 배포 브랜치를 통한 환경별 설정 관리 연습

## 📝 커밋 컨벤션

```
feat: 새로운 기능 추가
fix: 버그 수정
docs: 문서 수정
style: 코드 포맷팅, 세미콜론 누락 등
refactor: 코드 리팩토링
test: 테스트 코드 추가
chore: 빌드 과정 또는 보조 기능 수정
deploy: 배포 관련 변경
```

## 🔧 유용한 Git 명령어

```bash
# 브랜치 목록 확인
git branch -a

# 커밋 이력 확인 (선형)
git log --oneline --graph

# Rebase 진행 상황 확인
git status

# Rebase 중단
git rebase --abort

# 마지막 커밋 수정
git commit --amend

# 커밋 이력 정리 (interactive rebase)
git rebase -i HEAD~3
```