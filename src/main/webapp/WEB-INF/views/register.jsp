<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đăng Ký</title>
</head>
<body>
<div class="container">
    <!-- <h1 class="form-heading">login Form</h1> -->
    <div class="login-form">
        <div class="main-div">
            <div class="container-fluid">
                <section class="gradient-custom">
                    <div class="page-wrapper">
                        <div class="row d-flex justify-content-center align-items-center">
                            <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                                <div class="card text-white" style="border-radius: 1rem; background-color: #35bf76;">
                                    <div class="card-body p-5">
                                        <div class="mb-md-5 mt-md-4 pb-5 text-center">
                                            <h2 class="fw-bold mb-2 text-uppercase">Register</h2>
                                            <p class="text-white-50 mb-5">Please fill in the form to create an
                                                account</p>
                                            <form action="j_spring_security_check" id="formLogin" method="post">
                                                <div class="form-outline form-white mb-4">
                                                    <label class="form-label" for="fullName">Fullname</label>
                                                    <input type="text" class="form-control" id="fullName"
                                                           name="j_username" placeholder="Tên đầy đủ">
                                                </div>

                                                <div class="form-outline form-white mb-4">
                                                    <label class="form-label" for="userName">UseName</label>
                                                    <input type="text" class="form-control" id="userName"
                                                           name="j_username" placeholder="Tên đăng nhập">
                                                </div>

                                                <div class="form-outline form-white mb-4">
                                                    <label class="form-label" for="password">Password</label>
                                                    <input type="password" class="form-control" id="password"
                                                           name="j_password" placeholder="Mật khẩu">
                                                </div>

                                                <div class="form-outline form-white mb-4">
                                                    <label class="form-label" for="confirm">Confirm your
                                                        password</label>
                                                    <input type="text" class="form-control" id="confirm"
                                                           name="j_username" placeholder="Nhập lại password">
                                                </div>

                                                <div class="form-check d-flex justify-content-center mb-5" >
                                                    <div><input class="form-check-input me-2" type="checkbox" value=""
                                                                id="form2Example3cg"/></div>
                                                    <div><label class="form-check-label" id="CheckBox">
                                                        I agree all statements in <i>Terms of service</i>
                                                    </label></div>
                                                </div>


                                                <button class="btn btn-primary">Đăng ký</button>
                                            </form>
                                            <div class="d-flex justify-content-center text-center mt-2 pt-1">
                                                <a href="#!" class="login-extension text-white"><i
                                                        class="fab fa-facebook-f fa-lg"></i></a>
                                                <a href="#!" class="login-extension text-white"><i
                                                        class="fab fa-twitter fa-lg mx-4 px-2"></i></a>
                                                <a href="#!" class="login-extension text-white"><i
                                                        class="fab fa-google fa-lg"></i></a>
                                            </div>
                                        </div>
                                        <div class="text-center">
                                            <p class="mb-0 tex-center account">Don't have an account? <a
                                                    href="<c:url value='/login'/>"
                                                    class="text-white-50 fw-bold">Sign
                                                In</a></p>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>


        </div>
    </div>
</div>

<script>
    document.getElementById("formLogin").addEventListener("submit", function (event) {
        event.preventDefault(); // Ensure form does not submit automatically

        let isValid = true;

        // Get input values
        let fullName = document.getElementById("fullName").value.trim();
        let userName = document.getElementById("userName").value.trim();
        let password = document.getElementById("password").value;
        let confirmPassword = document.getElementById("confirm").value;
        let termsChecked = document.getElementById("form2Example3cg").checked;

        // Clear previous error messages
        document.querySelectorAll(".error-message").forEach(el => el.parentNode.removeChild(el));

        // Function to show error messages
        function showError(inputElement, message) {
            let errorDiv = document.createElement("div");
            errorDiv.className = "error-message";
            errorDiv.style.color = "red";
            errorDiv.style.fontSize = "12px";
            errorDiv.innerText = message;
            inputElement.parentNode.appendChild(errorDiv);
        }

        // Validate Full Name
        if (fullName.length < 3) {
            showError(document.getElementById("fullName"), "Full name must be at least 3 characters.");
            isValid = false;
        }

        // Validate Username
        if (userName.length < 3 || !/^[a-zA-Z0-9_]+$/.test(userName)) {
            showError(document.getElementById("userName"), "Username must be at least 3 characters and contain only letters, numbers, and underscores.");
            isValid = false;
        }

        // Validate Password
        if (password.length < 6) {
            showError(document.getElementById("password"), "Password must be at least 6 characters.");
            isValid = false;
        }

        // Confirm Password Match
        if (password !== confirmPassword) {
            showError(document.getElementById("confirm"), "Passwords do not match.");
            isValid = false;
        }

        // Validate Terms & Conditions Checkbox
        if (!termsChecked) {
            let termsContainer = document.getElementById("CheckBox").parentNode;
            showError(termsContainer, "You must agree to the Terms of Service.");
            isValid = false;
        }

        // If validation fails, stop form submission
        if (!isValid) {
            return;
        }

        // Create JSON Object for User Data
        var json = {
            fullName: fullName,
            userName: userName,
            password: password,
            roleCode: "USER"
        };

        // Call AJAX function
        registerNewUser(json);
    });

    function registerNewUser(data) {
        $.ajax({
            url: "/api/user/register",
            type: "POST",
            data: JSON.stringify(data),
            contentType: "application/json",
            success: function (response) {
                alert(response.message);
                if (response.message === "Create Success") {
                    window.location.href = "/login";
                }
            },
            error: function (xhr, status, error) {
                let responseJSON = xhr.responseJSON;
                if (responseJSON && responseJSON.message) {
                    alert(responseJSON.message);
                } else {
                    alert("Registration failed. Please try again.");
                }
            }
        });
    }

</script>

</body>
</html>