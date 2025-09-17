#!/bin/bash

# Git Branch Strategy Practice Setup Script
# 이 스크립트는 연습 환경을 자동으로 설정합니다.

echo "🚀 Git Branch Strategy Practice 환경 설정을 시작합니다..."

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 함수 정의
print_step() {
    echo -e "${BLUE}📋 $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Git 상태 확인
print_step "Git 상태 확인 중..."
if ! git status > /dev/null 2>&1; then
    print_error "Git 저장소가 초기화되지 않았습니다."
    exit 1
fi

# 현재 브랜치 확인
current_branch=$(git branch --show-current)
print_step "현재 브랜치: $current_branch"

# 브랜치 목록 확인
print_step "브랜치 목록 확인 중..."
git branch -a

# 연습용 브랜치 생성 함수
create_practice_branches() {
    print_step "연습용 브랜치들을 생성합니다..."
    
    # main 브랜치로 이동
    git checkout main
    
    # 연습용 feature 브랜치들 생성
    branches=(
        "feature/user-auth"
        "feature/user-profile"
        "feature/user-settings"
        "feature/api-endpoints"
        "feature/database-integration"
    )
    
    for branch in "${branches[@]}"; do
        if git show-ref --verify --quiet refs/heads/$branch; then
            print_warning "브랜치 $branch 가 이미 존재합니다."
        else
            git checkout -b $branch
            print_success "브랜치 $branch 생성 완료"
            git checkout main
        fi
    done
}

# 연습용 파일 생성 함수
create_practice_files() {
    print_step "연습용 파일들을 생성합니다..."
    
    # src 디렉토리 구조 생성
    mkdir -p src/auth/dto
    mkdir -p src/users
    mkdir -p src/api
    mkdir -p src/database
    
    print_success "디렉토리 구조 생성 완료"
}

# Git 설정 확인 및 안내
check_git_config() {
    print_step "Git 설정 확인 중..."
    
    # 사용자 이름 확인
    if ! git config user.name > /dev/null 2>&1; then
        print_warning "Git 사용자 이름이 설정되지 않았습니다."
        echo "다음 명령어로 설정하세요:"
        echo "git config --global user.name 'Your Name'"
    fi
    
    # 사용자 이메일 확인
    if ! git config user.email > /dev/null 2>&1; then
        print_warning "Git 사용자 이메일이 설정되지 않았습니다."
        echo "다음 명령어로 설정하세요:"
        echo "git config --global user.email 'your.email@example.com'"
    fi
}

# 연습 가이드 출력
print_practice_guide() {
    print_step "연습 가이드"
    echo ""
    echo "📚 연습을 시작하려면:"
    echo "1. PRACTICE_SCENARIOS.md 파일을 읽어보세요"
    echo "2. 각 시나리오를 순서대로 따라해보세요"
    echo "3. Git 이력이 선형으로 유지되는지 확인하세요"
    echo ""
    echo "🔧 유용한 명령어:"
    echo "  git log --oneline --graph --all  # 이력 확인"
    echo "  git status                       # 현재 상태 확인"
    echo "  git branch -a                    # 브랜치 목록 확인"
    echo ""
    echo "🎯 연습 목표:"
    echo "  - Rebase를 사용한 선형 이력 관리"
    echo "  - 브랜치 간 충돌 해결"
    echo "  - 배포 브랜치 관리"
    echo "  - Git 워크플로우 숙달"
}

# 메인 실행
main() {
    echo "=========================================="
    echo "🎓 Git Branch Strategy Practice Setup"
    echo "=========================================="
    echo ""
    
    check_git_config
    create_practice_branches
    create_practice_files
    
    echo ""
    print_success "환경 설정이 완료되었습니다!"
    echo ""
    print_practice_guide
    
    echo ""
    echo "=========================================="
    print_success "연습을 시작하세요! 🚀"
    echo "=========================================="
}

# 스크립트 실행
main
