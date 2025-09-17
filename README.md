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

## 🔄 Git 워크플로우 (완성된 전략)

### 📋 브랜치 역할 정의

- **Feature 브랜치**: 실제 개발 작업 수행 ✅
- **Main 브랜치**: 원천 소스 관리, Feature 브랜치들의 병합점 ✅
- **Deploy 브랜치**: Main 소스만 반영, 직접 개발 금지 ❌

### 1. 기능 개발 워크플로우 (Feature → Main)

```bash
# 1. Feature 브랜치에서 작업 및 커밋
git add .
git commit -m 'feat: add new feature'

# 2. Main 최신화 및 rebase
git checkout main
git pull origin main
git checkout feature/branch-name
git rebase main

# 3. Main에 병합 (Fast-forward)
git checkout main
git merge feature/branch-name

# 4. 원격 저장소에 푸시 (Feature 먼저, Main 나중에)
git checkout feature/branch-name
git push origin feature/branch-name
git checkout main
git push origin main

# 5. 브랜치 정리 (선택사항)
git branch -d feature/branch-name
git push origin --delete feature/branch-name
```

### 2. 배포 브랜치 업데이트 워크플로우 (Main → Deploy)

**⚠️ 중요**: Deploy 브랜치에서는 직접 개발하지 않고, Main의 변경사항만 반영합니다.

```bash
# Main에 새로운 기능이 추가된 후

# 1. 개발 환경 배포 브랜치 업데이트
git checkout deploy/development/app
git merge main                    # 또는 git rebase main
git push origin deploy/development/app

# 2. 운영 환경 배포 브랜치 업데이트
git checkout deploy/production/app
git merge main                    # 또는 git rebase main
git push origin deploy/production/app
```

### 3. 전체 워크플로우 흐름

```
Feature 개발 → Main 병합 → Main 푸시
                 ↓
Deploy 브랜치들이 Main 변경사항을 가져와서 업데이트
```

### 4. 다중 Feature 브랜치 시나리오

만약 Main에 다른 팀원의 작업이 3개 추가된 상황:

```bash
# 상황: Main이 업데이트된 후 내 Feature 작업 완료
git checkout main
git pull origin main              # 다른 팀원들의 작업 3개 가져오기
git checkout feature/my-work
git rebase main                   # 내 작업을 최신 Main 위로 재배치
git checkout main
git merge feature/my-work         # Fast-forward 병합

# 결과: 완벽한 선형 이력 유지 🎉
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

### 핵심 원칙

1. **Feature 브랜치**: 개발의 시작점 ✅
2. **Main 브랜치**: 모든 변경사항의 집합점 ✅
3. **Deploy 브랜치**: Main의 반영점 (개발 금지) ❌

### 학습 순서

1. **기본 Git 명령어 숙지**
2. **Rebase vs Merge 이해**
3. **선형 이력 관리의 중요성**
4. **충돌 해결 방법 연습**
5. **브랜치 역할 분리 이해**

## 🎮 연습 방법

### 기본 연습

1. Feature 브랜치에서 기능 개발
2. Main 브랜치로 rebase 및 병합
3. Deploy 브랜치에 Main 변경사항 반영
4. 선형 이력 유지 확인

### 고급 연습

1. 다중 Feature 브랜치 동시 작업
2. 충돌 상황에서의 rebase 연습
3. 협업 시나리오에서의 브랜치 관리
4. Deploy 브랜치 역할 분리 연습

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
