/**
 * 
 */
 $(document).ready(function() {
		// 아이디 중복 확인
		$('#duplication-btn').on('click', function() {
			let loginId = $('#loginId').val().trim();
			
			$('.id-check-row').addClass('d-none');
			
			// vaildation check
			if (loginId.length < 4) {
				// id가 4글자 미만일 때 경고문구 노출
				$('.id-check-row').removeClass('d-none');
				$('#idCheckLength').removeClass('d-none');
				return;
			}
			
			if (loginId == '') {
				alert("아이디를 입력해주세요.");
				return;
			}
			
			$.ajax({
				url: "/user/is_duplicated_id"
				, data: {"loginId": loginId}
				, success: function(data) {
					$('.id-check-row').addClass('d-none');
					if (data.result == true) {
						// 중복일 때
						$('.id-check-row').removeClass('d-none');
						$('.is-duplicated').removeClass('d-none');
						$('.is-not-duplicated').addClass('d-none');
						$('#idCheckLength').addClass('d-none');
					} else {
						// 중복이 아닐때
						$('.id-check-row').removeClass('d-none');
						$('.is-duplicated').addClass('d-none');
						$('.is-not-duplicated').removeClass('d-none');
						$('#idCheckLength').addClass('d-none');
					}
				}
				, error: function(e){
					alert("아이디 중복 확인에 실패했습니다. 관리자에게 문의해 주세요.");
				}
			});
		});
		
		// 회워가입 풀이 - form
		$('#signUpForm').on('submit', function(e) {
			e.preventDefault(); // 서브밋 기능 중단
			
			// validation
			let loginId = $('#loginId').val().trim();
			if (loginId == '') {
				alert("아이디를 입력해주세요.");
				return false;
			}
			
			let password = $('#password').val().trim();
			let confirmPw = $('#confirmPw').val().trim();
			if (password == '' || confirmPw == '') {
				alert("비밀번호를 입력해주세요.");
				return false;
			}
			
			if (password != confirmPw) {
				alert("비밀번호가 일치하지않습니다.");
				// 텍스트의 값을 초기화 한다.
				$('#password').val('');
				$('#confirmPw').val('');
				return false;
			}
			
			let name = $('#name').val().trim();
			if (name == '') {
				alert("이름을 입력해주세요.");
				return false;
			}
			
			let email = $('#email').val().trim();
			if (email == '') {
				alert("이메일 주소를 입력해주세요.");
				return false;
			}
			
			// 아이디 중복 확인이 되었는지 확인
			// is-not-duplicated 클래스 중 d-none이 있는 경우 => return => 회원가입 X
			if ($('.is-not-duplicated').hasClass('d-none')) {
				alert("아이디 중복 확인을 해주세요.");
				return false;
			}
			
			// submit
			// 1. form으로 서브밋 => 응답이 화면이 됨
			// $(this)[0].submit();
			
			// 2. ajax 서브밋 => 응답이 데이터가 됨
			let url = $(this).attr('action');	// form 태그에 있는 action 주소를 가져오는 방법
			// alert(url);
			let params = $(this).serialize();	// 폼 태그에 있는 값을 한번에 보낼 수 있게 구성한다(name 속성)
			// console.log(params);
			$.post(url, params)
			.done(function(data){
				if (data.result == "success") {
					alert("회원 가입을 환영합니다. \n로그인을 해주세요.");
					location.href = "/user/sign_in_view";
				} else {
					alert("회원 가입에 실패했습니다. 다시 시도해주세요.");
				}
			});
		});
		
		// 비밀번호 확인
		/* $('#password').focus(function() {
			$('.password-check-row').addClass('d-none');
		});
		$('#confirmPw').focusout(function() {
			let password = $('#password').val().trim();
			let confirmPw = $('#confirmPw').val().trim();
			if (password != confirmPw) {
				$('.password-check-row').removeClass('d-none');
				document.getElementById('password').value = null;
				document.getElementById('confirmPw').value = null;
			}
		}); */
		
		// 회원가입 버튼
		/* $('#join-btn').on('click', function() {
			let loginId = $('#loginId').val().trim();
			let password = $('#password').val().trim();
			let confirmPw = $('#confirmPw').val().trim();
			let name = $('#name').val().trim();
			let email = $('#email').val().trim();
			
			// validation
			if (loginId == '') {
				alert("아이디를 입력해주세요.");
				return;
			}
			if ($('.id-check-row').hasClass('d-none')) {
				alert("아이디 중복확인을 해주세요.");
				return;
			}
			
			if (password == '') {
				alert("비밀번호를 입력해주세요.");
				return;
			}
			if (!$('.password-check-row').hasClass('d-none')) {
				alert("비밀번호를 확인해주세요.");
				return;
			} 
			
			if (name == '') {
				alert("이름을 입력해주세요.");
				return;
			}
			if (email == '') {
				alert("이메일 주소를 입력해주세요.");
				return;
			}
			
			$.ajax({
				type: "POST"
				, url: "/user/sign_up"
				, data: {"loginId": loginId, "password": password, "name": name, "email": email}
				, success: function(data) {
					if (data.result == "success") {
						alert(loginId + "님 회원가입이 완료되었습니다.");
						location.reload();
					}
				}
				, error: function(e) {
					alert("관리자에게 문의하세요.");
				}
			});
		}); */
	});