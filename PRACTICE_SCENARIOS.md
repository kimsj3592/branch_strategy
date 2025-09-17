# Git Branch Strategy 연습 시나리오

이 문서는 Git 브랜치 전략과 rebase를 사용한 선형 이력 관리를 연습하기 위한 다양한 시나리오를 제공합니다.

## 🎯 연습 목표

- Rebase를 사용한 선형 이력 관리
- 브랜치 간 충돌 해결
- 배포 브랜치 관리
- Git 워크플로우 숙달

## 📋 시나리오 목록

### 시나리오 1: 기본 기능 개발 워크플로우

**목표**: 사용자 인증 모듈을 추가하는 기본적인 기능 개발 과정을 연습합니다.

**단계**:

1. `feature/user-auth` 브랜치 생성
2. 사용자 인증 관련 파일들 생성
3. 커밋 생성
4. main으로 rebase 및 병합

**실행 명령어**:

```bash
# 1. main 브랜치에서 최신 상태로 업데이트
git checkout main
git pull origin main

# 2. feature 브랜치 생성
git checkout -b feature/user-auth

# 3. 사용자 인증 모듈 생성 (아래 파일들 생성)
# - src/auth/auth.module.ts
# - src/auth/auth.controller.ts
# - src/auth/auth.service.ts
# - src/auth/dto/login.dto.ts

# 4. 커밋
git add .
git commit -m "feat: add user authentication module"

# 5. main으로 rebase
git checkout main
git pull origin main
git checkout feature/user-auth
git rebase main

# 6. main으로 병합
git checkout main
git merge feature/user-auth

# 7. feature 브랜치 삭제
git branch -d feature/user-auth
```

### 시나리오 2: 충돌 해결 연습

**목표**: 동시에 같은 파일을 수정하여 충돌이 발생하는 상황을 연습합니다.

**준비 작업**:

1. 두 개의 feature 브랜치를 동시에 생성
2. 같은 파일을 수정하여 충돌 유발
3. Rebase 중 충돌 해결

**실행 명령어**:

```bash
# 1. 첫 번째 feature 브랜치
git checkout main
git checkout -b feature/user-profile
# app.service.ts 파일 수정 (사용자 프로필 관련 메서드 추가)
git add . && git commit -m "feat: add user profile functionality"

# 2. 두 번째 feature 브랜치
git checkout main
git checkout -b feature/user-settings
# app.service.ts 파일 수정 (사용자 설정 관련 메서드 추가)
git add . && git commit -m "feat: add user settings functionality"

# 3. 첫 번째 브랜치를 main에 병합
git checkout main
git merge feature/user-profile

# 4. 두 번째 브랜치를 rebase (충돌 발생)
git checkout feature/user-settings
git rebase main
# 충돌 해결 후
git add .
git rebase --continue

# 5. main으로 병합
git checkout main
git merge feature/user-settings
```

### 시나리오 3: 배포 브랜치 업데이트

**목표**: main 브랜치의 변경사항을 배포 브랜치에 반영하는 과정을 연습합니다.

**실행 명령어**:

```bash
# 1. main 브랜치에 새로운 기능 추가
git checkout main
git checkout -b feature/new-feature
# 새로운 기능 개발
git add . && git commit -m "feat: add new feature"
git checkout main
git merge feature/new-feature

# 2. 개발 환경 배포 브랜치 업데이트
git checkout deploy/development/app
git rebase main
# 개발 환경 설정 조정
git add . && git commit -m "deploy: update development config for new feature"

# 3. 운영 환경 배포 브랜치 업데이트
git checkout deploy/production/app
git rebase main
# 운영 환경 설정 조정
git add . && git commit -m "deploy: update production config for new feature"
```

### 시나리오 4: Hotfix 처리

**목표**: 운영 환경에서 긴급 수정이 필요한 상황을 연습합니다.

**실행 명령어**:

```bash
# 1. hotfix 브랜치 생성 (main에서)
git checkout main
git checkout -b hotfix/critical-bug-fix

# 2. 긴급 수정 작업
# 버그 수정 코드 작성
git add . && git commit -m "fix: resolve critical security vulnerability"

# 3. main에 병합
git checkout main
git merge hotfix/critical-bug-fix

# 4. 운영 배포 브랜치에 즉시 반영
git checkout deploy/production/app
git rebase main
git add . && git commit -m "deploy: apply critical hotfix to production"

# 5. 개발 배포 브랜치에도 반영
git checkout deploy/development/app
git rebase main
git add . && git commit -m "deploy: apply critical hotfix to development"
```

### 시나리오 5: Interactive Rebase 연습

**목표**: 커밋 이력을 정리하고 수정하는 과정을 연습합니다.

**실행 명령어**:

```bash
# 1. 여러 개의 작은 커밋 생성
git checkout main
git checkout -b feature/multiple-commits

# 여러 번의 작은 변경사항과 커밋
echo "// First change" >> src/app.service.ts
git add . && git commit -m "WIP: first change"

echo "// Second change" >> src/app.service.ts
git add . && git commit -m "WIP: second change"

echo "// Third change" >> src/app.service.ts
git add . && git commit -m "WIP: third change"

# 2. Interactive rebase로 커밋 정리
git rebase -i HEAD~3
# 에디터에서:
# - pick을 squash로 변경하여 커밋 합치기
# - 커밋 메시지 수정

# 3. main으로 병합
git checkout main
git merge feature/multiple-commits
```

## 🛠️ 연습용 파일 템플릿

### 사용자 인증 모듈 (시나리오 1용)

**src/auth/auth.module.ts**:

```typescript
import { Module } from '@nestjs/common';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';

@Module({
  controllers: [AuthController],
  providers: [AuthService],
})
export class AuthModule {}
```

**src/auth/auth.controller.ts**:

```typescript
import { Controller, Post, Body } from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginDto } from './dto/login.dto';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('login')
  async login(@Body() loginDto: LoginDto) {
    return this.authService.login(loginDto);
  }
}
```

**src/auth/auth.service.ts**:

```typescript
import { Injectable } from '@nestjs/common';
import { LoginDto } from './dto/login.dto';

@Injectable()
export class AuthService {
  async login(loginDto: LoginDto) {
    // 실제 구현은 연습용이므로 간단하게
    return {
      message: 'Login successful',
      user: loginDto.username,
    };
  }
}
```

**src/auth/dto/login.dto.ts**:

```typescript
export class LoginDto {
  username: string;
  password: string;
}
```

## 📊 연습 체크리스트

각 시나리오를 완료한 후 다음 사항들을 확인해보세요:

- [ ] Git 이력이 선형으로 유지되었는가?
- [ ] 충돌이 발생했을 때 올바르게 해결했는가?
- [ ] 커밋 메시지가 컨벤션을 따르고 있는가?
- [ ] 불필요한 브랜치가 정리되었는가?
- [ ] 배포 브랜치가 올바르게 업데이트되었는가?

## 🎓 고급 연습

### 연습 1: 복잡한 충돌 해결

- 3개 이상의 브랜치에서 같은 파일의 다른 부분을 수정
- 3-way merge 충돌 해결 연습

### 연습 2: Cherry-pick 연습

- 특정 커밋만 다른 브랜치에 적용
- Hotfix를 여러 브랜치에 선택적으로 적용

### 연습 3: Rebase vs Merge 비교

- 같은 변경사항을 rebase와 merge로 각각 적용
- 이력의 차이점 관찰

## 💡 팁과 주의사항

1. **Rebase 전에 항상 백업**: `git branch backup-branch-name`
2. **충돌 해결 시 신중하게**: 충돌 해결 후 테스트 필수
3. **커밋 메시지 일관성**: 컨벤션을 지켜서 작성
4. **브랜치 정리**: 작업 완료 후 불필요한 브랜치 삭제
5. **이력 확인**: `git log --oneline --graph`로 이력 확인

## 🔍 문제 해결

### Rebase 중 문제 발생 시

```bash
# Rebase 중단
git rebase --abort

# 이전 상태로 복원
git reset --hard HEAD~1
```

### 잘못된 커밋 메시지 수정

```bash
# 마지막 커밋 메시지 수정
git commit --amend -m "올바른 커밋 메시지"

# 여러 커밋 메시지 수정
git rebase -i HEAD~3
```

### 브랜치 상태 확인

```bash
# 현재 브랜치와 상태 확인
git status

# 브랜치 목록 확인
git branch -a

# 커밋 이력 확인
git log --oneline --graph --all
```
