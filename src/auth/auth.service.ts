import { Injectable } from '@nestjs/common';
import { LoginDto } from './dto/login.dto';
import { RegisterDto } from './dto/register.dto';

@Injectable()
export class AuthService {
  private users = []; // 실제로는 데이터베이스 사용

  async login(loginDto: LoginDto) {
    const user = this.users.find((u) => u.email === loginDto.email);

    if (!user) {
      throw new Error('User not found');
    }

    return {
      message: 'Login successful',
      user: {
        id: user.id,
        email: user.email,
        name: user.name,
      },
      token: 'jwt-token-here', // 실제로는 JWT 토큰 생성
    };
  }

  async register(registerDto: RegisterDto) {
    // 실제 구현에서는 비밀번호 해싱, 중복 검사 등
    const newUser = {
      id: Date.now(),
      ...registerDto,
      createdAt: new Date(),
    };

    this.users.push(newUser);

    return {
      message: 'User registered successfully',
      user: {
        id: newUser.id,
        email: newUser.email,
        name: newUser.name,
      },
    };
  }

  async getProfile() {
    // 실제 구현에서는 JWT 토큰에서 사용자 정보 추출
    return {
      message: 'Profile retrieved successfully',
      user: {
        id: 1,
        email: 'user@example.com',
        name: 'John Doe',
      },
    };
  }
}
