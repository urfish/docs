# Linux 
## CommandList
### 32비트 64 비트확인
    getconf LONG_BIT  
---
    arch
---
    uname -m
---
    echo $HOSTTYPE
---
    lscpu | grep ^Arch

### 리눅스 버전확인
#### 배포판 버전확인
    grep . /etc/*-release
---
    cat /etc/*-release | uniq
---
    grep . /etc/issue*
---
    
> Written with [StackEdit](https://stackedit.io/).
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTM3NzM4ODk4NiwyMzgwNjM1MjhdfQ==
-->