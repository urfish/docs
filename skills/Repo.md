---
sort: 2
text: |
  
---
# Repo 
## 1 Repo 명령어

Repo는 여러 저장소 전체에 걸친 작업을 단순화하여 Git를 보완합니다.  
Repo 및 Git 간의 관계에 관한 설명은 [소스 제어 도구](https://source.android.google.cn/setup/develop?hl=ko)를 참조하세요. 
 Repo에 관한 자세한 내용은 Repo [README](https://gerrit.googlesource.com/git-repo/+/refs/heads/master/README.md)를 참조하세요.

Repo는 다음 형식을 취합니다.

```javascript
repo command options
```
선택적 요소는 대괄호 [ ] 안에 표시됩니다. 예를 들어, 많은 명령어가 project-list를 인수로 취합니다. 다음과 같이 project-list를 프로젝트의 이름 목록 또는 로컬 소스 디렉터리 경로 목록으로 지정할 수 있습니다.

```repo
repo sync [project0 project1 ... projectn]
repo sync [/path/to/project0 ... /path/to/projectn]
```

## 2 Repo 도움말
이 페이지는 단순히 주요 옵션을 강조합니다.  
전체적인 세부정보는 명령줄 도움말을 참조하세요.  
Repo가 설치되면 다음을 실행하여 모든 명령어의 요약과 함께 시작되는 최신 문서를 찾을 수 있습니다.

```repo
repo help
```
Repo 트리 내에서 다음을 실행하여 모든 명령어에 관한 세부정보를 확인할 수 있습니다.

```repo
repo help command
```
예를 들어, 다음 명령어는 현재 디렉터리에서 Repo를 초기화하는 Repo의 init 인수에 관한 설명과 옵션 목록을 반환합니다 (세부정보는 init를 참조하세요.)

```
repo help init
```
가용한 옵션 목록을 확인하려면 다음을 실행하세요.

```
repo **command** --help
repo init --help  // 예제
```

초기화
```
repo init -u url [options]
```
현재 디렉터리에 Repo를 설치합니다. 이 명령어는 Repo 소스 코드 및 표준 Android 매니페스트 파일의 Git 저장소가 포함된 .repo/ 디렉터리를 생성합니다.

옵션:

- **-u**: 매니페스트 저장소를 가져올 URL을 지정합니다.  
공통 매니페스트는 https://android.googlesource.com/platform/manifest에서 찾을 수 있습니다.
- **-m**: 저장소에서 매니페스트 파일을 선택합니다. 매니페스트 이름을 선택하지 않으면 기본값은 default.xml입니다.
- **-b**: 버전, 즉 특정 manifest-branch를 지정합니다.

참고: 나머지 모든 Repo 명령어의 경우 현재 작업 디렉터리가 .repo/의 상위 디렉터리이거나 상위 디렉터리의 하위 디렉터리여야 합니다.

##동기화
```
repo sync [**project-list**]
```
새로운 변경사항을 다운로드하고 로컬 환경의 작업 파일을 업데이트하여 본질적으로 전체 Git 저장소에 걸쳐 git fetch를 실행합니다. 인수 없이 repo sync를 실행하면 모든 프로젝트의 파일을 동기화합니다.

repo sync를 실행하면 다음과 같은 결과가 발생합니다.

프로젝트가 동기화된 적이 없다면 repo sync는 git clone과 같습니다. 원격 저장소의 모든 분기가 로컬 프로젝트 디렉터리에 복사됩니다.

이전에 프로젝트가 동기화된 적이 있다면 repo sync는 다음과 같습니다.

```
git remote update
git rebase origin/branch
```
여기서 branch는 로컬 프로젝트 디렉터리에서 현재 체크아웃된 분기입니다. 로컬 분기에서 원격 저장소의 분기를 추적하지 않고 있다면 프로젝트의 동기화는 발생하지 않습니다.

Git 리베이스 작업으로 인해 병합 충돌이 발생한다면 일반 Git 명령어(예: git rebase --continue)를 사용하여 충돌을 해결합니다.

repo sync를 성공적으로 실행한 후에는 지정된 프로젝트의 코드가 최신 버전이며 원격 저장소에 있는 코드와 동기화됩니다.

주요 옵션은 다음과 같습니다. 자세한 내용은 repo help sync를 참조하세요.

- **-c**: 서버에서 현재 manifest 분기만 가져옵니다.

- **-d**: 지정된 프로젝트를 매니페스트 버전으로 다시 전환합니다.  
이는 프로젝트가 현재 주제 분기에 있지만, 매니페스트 버전이 임시로 필요한 경우에 유용합니다.

- **-f**: 프로젝트가 동기화에 실패한 경우에도 다른 프로젝트의 동기화를 진행합니다.

- **-j threadcount**: 동기화를 여러 스레드로 분할하여 완료 시간을 단축합니다.  
시스템에 부담이 되지 않도록 다른 작업을 위한 어느 정도의 CPU를 남겨 놓으세요.  
사용 가능한 CPU 수를 보려면 먼저 nproc --all을 실행합니다.

- **-q**: 상태 메시지를 표시하지 않고 조용히 실행됩니다.

- **-s**: 현재 매니페스트의 manifest-server 요소에 지정된 대로 양호하다고 알려진 빌드로 동기화합니다.

upload
```
repo upload [project-list]
```
지정된 프로젝트의 경우 Repo는 로컬 분기를 최근의 Repo 동기화 도중에 업데이트된 원격 분기와 비교합니다. Repo는 검토를 위해 업로드되지 않은 하나 이상의 분기를 선택하도록 요청합니다.

그러면 선택한 분기의 모든 커밋이 HTTPS 연결을 통해 Gerrit로 전송됩니다. HTTPS 비밀번호를 구성하여 업로드 승인을 사용 설정해야 합니다. 비밀번호 생성기로 이동하여 HTTPS를 통해 사용할 새로운 사용자 이름/비밀번호를 생성합니다.

Gerrit는 자체 서버를 통해 객체 데이터를 수신한 후 검토자가 특정 커밋에 관한 의견을 제시할 수 있도록 각 커밋에 변경사항을 적용합니다. 여러 개의 체크포인트 커밋을 하나의 커밋으로 결합하려면 업로드를 실행하기 전에 `git rebase -i`를 사용합니다.

인수 없이 repo upload를 실행하면 모든 프로젝트에서 업로드할 변경사항을 검색합니다.

업로드된 변경사항을 수정하려면 `git rebase -i` 또는 `git commit --amend`와 같은 도구를 사용하여 로컬 커밋을 업데이트합니다. 수정이 완료된 후에는 다음을 실행합니다.

업데이트된 분기가 현재 확인된 분기인지 확인합니다.
시리즈의 각 커밋마다 대괄호 안에 Gerrit 변경사항 ID를 입력합니다.

```
# Replacing from branch foo
[ 3021 ] 35f2596c Refactor part of GetUploadableBranches to lookup one specific...
[ 2829 ] ec18b4ba Update proto client to support patch set replacments
# Insert change numbers in the brackets to add a new patch set.
# To create a new change record, leave the brackets empty.
```
업로드가 완료되면 변경사항에 추가 경로 집합이 생깁니다.

현재 체크아웃된 Git 분기만 업로드하려면 `--current-branch` 플래그(또는 단축형으로 `--cbr`)를 사용합니다.

diff
```
repo diff [project-list]
git diff를 사용하여 커밋과 작업 트리 간의 적용되지 않은 변경사항을 표시합니다.
```
download
```
repo download target change
```
검토 시스템에서 지정된 변경사항을 다운로드하여 프로젝트의 로컬 작업 디렉터리에서 사용할 수 있게 합니다.

예를 들어, 변경사항 23823을 플랫폼/빌드 디렉터리에 다운로드하려면 다음을 사용합니다.

```
repo download platform/build 23823
```
repo sync를 실행하면 repo download로 가져온 모든 커밋이 삭제됩니다. 또는 `git checkout m/master`를 사용하여 원격 분기를 체크아웃할 수 있습니다.

참고: 전 세계 모든 서버에 복제 지연이 있기 때문에 변경사항이 Gerrit 웹에 표시되는 시점과 repo download가 모든 사용자의 변경사항을 발견할 수 있는 시점 간에 약간의 미러링 지연시간이 있습니다.

forall
```
repo forall [project-list] -c command
```
각 프로젝트에서 주어진 shell 명령어를 실행합니다. repo forall에서 사용할 수 있는 추가 환경 변수는 다음과 같습니다.

- **REPO_PROJECT**는 프로젝트의 고유 이름으로 설정됩니다.

- **REPO_PATH**는 클라이언트 루트의 상대 경로입니다.

- **REPO_REMOTE**는 매니페스트의 원격 시스템 이름입니다.

- **REPO_LREV**는 매니페스트의 버전 이름이며, 로컬 추적 분기로 해석됩니다. 매니페스트 버전을 로컬에서 실행되는 Git 명령어로 전달해야 할 때에 사용합니다.

- **REPO_RREV**는 매니페스트의 수정본 이름이며, 매니페스트에 작성된 형식과 동일합니다.

옵션:

- **-c**: 실행할 명령어 및 인수입니다. 명령어는 /bin/sh를 통해 평가되며 이후의 모든 인수는 셸 위치 매개변수를 통해 전달됩니다.

- **-p**: 지정된 명령어의 출력 앞에 프로젝트 헤더를 표시합니다. 이는 명령어의 stdin, stdout 및 sterr 스트림에 파이프를 결합하고 단일 페이지 세션에 표시된 연속 스트림으로 모든 출력을 파이핑하여 실행됩니다.

- **-v**: 명령어가 stderr에 기록한 메시지를 표시합니다.

prune
```
repo prune [project-list]
```
이미 병합된 주제를 프루닝(삭제)합니다.

start
```
repo start
branch-name [**project-list**]
```
매니페스트에 지정된 수정본에서 시작되는 새로운 개발 분기를 시작합니다.

**BRANCH_NAME** 인수는 프로젝트에 적용하려는 변경사항에 관한 간단한 설명을 제공합니다. 잘 모른다면 `default`라는 이름을 사용해보세요.  

**project-list** 인수는 이 주제 분기에 참여하는 프로젝트를 지정합니다.

참고: 마침표( . )는 현재 작업 디렉터리에 있는 프로젝트의 단축 표현입니다.

status
```
repo status [project-list]
```

작업 트리를 준비 영역(색인), 그리고 지정된 각 프로젝트의 이 분기(HEAD)에 관한 가장 최근의 커밋과 비교합니다. 이러한 세 개의 상태 간에 차이점이 있는 각 파일의 요약 줄을 표시합니다.

현재 분기의 상태만 보려면 repo status를 실행합니다. 상태 정보가 프로젝트별로 나열됩니다. 프로젝트의 각 파일에 두 자리 코드가 사용됩니다.

첫 번째 열의 대문자는 준비 영역이 마지막으로 커밋된 상태와 어떻게 다른지 나타냅니다.

| 글자	| 의미	| 설명|
| -	| 변경사항 없음	| HEAD 및 색인에서 동일|
|A| 추가됨	| HEAD에 없음, 색인에 있음 |
| M	| 마지막 수정 시간	| HEAD에 있음, 색인에서 수정됨|
| D	| 삭제됨	| HEAD에 있음, 색인에 없음 |
| R	| 이름이 변경됨	| HEAD에 없음, 색인에서 경로가 변경됨|
| C	| 복사됨	| HEAD에 없음, 색인의 다른 항목에서 복사됨|
| T	| 모드 변경됨	| HEAD 및 색인의 동일한 콘텐츠, 모드 변경됨|
| U	| 병합 취소됨	| HEAD 및 색인 간 충돌, 해결 필요|

두 번째 열의 소문자는 작업 디렉터리가 색인과 어떻게 다른지 나타냅니다.

| 글자	| 의미	| 설명|
| -	| 신규/알 수 없음	| 색인에 없음, 작업 트리에 있음|
| m	| 마지막 수정 시간	| 색인에 있음, 작업 트리에 있음, 수정됨|
| d	| 삭제됨	| 색인에 있음, 작업 트리에 없음|
