<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="resources/css/main.css" />

<div class="form-container">
	<h1 class="form-title">메일 작성</h1>
	<form id="mailForm" enctype="multipart/form-data">
		<div class="form-group">
			<label for="emailAddress">받는 사람</label>
			<input type="email" id="emailAddress" name="emailAddress" placeholder="example@example.com" required>
		</div>
		<div class="form-group">
			<label for="referenceEmailAddress">참조</label> 
			<input type="text" id="referenceEmailAddress" name="referenceEmailAddress" placeholder="참조할 이메일 주소">
		</div>
		<div class="form-group">
			<label for="emailTitle">제목</label> 
			<input type="text" id="emailTitle" name="emailTitle" placeholder="메일 제목을 입력하세요" required>
		</div>
		<div class="form-group">
			<label for="emailContent">내용</label>
			<textarea id="emailContent" name="emailContent" placeholder="내용을 입력하세요" required></textarea>
		</div>
		<div class="file-upload-container">
			<label for="files">파일 첨부</label> 
			<input type="file" id="files" name="files" multiple style="display: none;">
			<button class="add-file-btn" type="button" onclick="addFile()">파일 추가</button>
			<div class="file-list" id="fileList"></div>
			<div class="upload-info" id="uploadInfo">0/10 파일 첨부</div>
		</div>
		<button type="button" class="submit-btn" onclick="sendMail(event);">발송하기</button>
	</form>
</div>

<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<script>
const fileInput = document.getElementById('files');
const fileListContainer = document.getElementById('fileList');
const uploadInfo = document.getElementById('uploadInfo');

const maxFiles = 10;
let selectedFiles = [];

// 파일 추가 버튼 클릭 시 파일 선택 창 열기
function addFile() {
    fileInput.click();
}

// 파일 선택 시 처리
fileInput.addEventListener('change', function () {
    const newFiles = Array.from(fileInput.files);

    // 최대 파일 개수 초과 시 경고
    if (selectedFiles.length + newFiles.length > maxFiles) {
        alert('최대 10개의 파일만 첨부할 수 있습니다.');
        fileInput.value = '';
        return;
    }

    // 새로운 파일 추가
    newFiles.forEach((file) => {
        selectedFiles.push(file);
        displayFile(file);
    });

    updateUploadInfo();
    fileInput.value = '';
});

// 파일 리스트 UI 갱신
function displayFile(file) {
    const fileItem = document.createElement('div');
    fileItem.className = 'file-item';

    const fileName = document.createElement('span');
    fileName.textContent = file.name;

    const removeButton = document.createElement('button');
    removeButton.textContent = 'X';
    removeButton.addEventListener('click', () => {
        removeFile(file);
        fileItem.remove();
        updateUploadInfo();
    });

    fileItem.appendChild(fileName);
    fileItem.appendChild(removeButton);
    fileListContainer.appendChild(fileItem);
}

// 파일 제거
function removeFile(file) {
    selectedFiles = selectedFiles.filter((f) => f !== file);
}

// 첨부 파일 상태 업데이트
function updateUploadInfo() {
    uploadInfo.textContent = `\${selectedFiles.length}/\${maxFiles} 파일 첨부`;
}

// 메일 발송 함수
function sendMail(event) {
    event.preventDefault();
    const formData = new FormData(document.getElementById('mailForm'));
    selectedFiles.forEach((file) => formData.append('files', file));
    fetch('/sendMail', {
        method: 'POST',
        body: formData,
    })
        .then((response) => {
            if (!response.ok) {
                throw new Error('서버 응답 실패');
            }
            return response.json();
        })
        .then((data) => {
            if (data.status === 'success') {
                alert(data.message);
            } else {
                alert('메일 발송 실패: ' + data.message);
            }
            console.log('서버 응답:', data);
        })
        .catch((error) => {
            alert('메일 발송 중 오류 발생: ' + error.message);
        });
}


</script>