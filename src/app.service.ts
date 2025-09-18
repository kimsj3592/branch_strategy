import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello(): string {
    return 'Hello World! Branch Strategy Practice Project';
  }

  getHealth(): object {
    console.log('test');
    console.log('test1');
    console.log('git test!!!!')
    console.log('for git test!')
    console.log('third test')
    return {
      status: 'ok',
      timestamp: new Date().toISOString(),
      environment: process.env.NODE_ENV || 'development',
    };
  }
}
