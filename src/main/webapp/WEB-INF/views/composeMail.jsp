<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <form action="/sendMail" method="post">
        <div>
            <label for="email">이메일 주소</label>
            <input type="email" id="email" name="email" placeholder="example@example.com" required>
        </div>
        <div>
            <label for="message">내용</label>
            <textarea id="message" name="message" rows="5" cols="30" placeholder="내용을 입력하세요" required></textarea>
        </div>
        <button type="submit">발송하기</button>
    </form>
    <script>
        document.querySelector('form').addEventListener('submit', function (e) {
            const email = document.getElementById('email').value.trim();
            const message = document.getElementById('message').value.trim();

            if (!email || !message) {
                e.preventDefault();
                alert('모든 필드를 채워주세요.');
            } else if (!/\S+@\S+\.\S+/.test(email)) {
                e.preventDefault();
                alert('올바른 이메일 주소를 입력해주세요.');
            }
        });
    </script>
