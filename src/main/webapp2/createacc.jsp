<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account - NeoVault Bank</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body, html {
            height: 100vh;
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 50%, #e9ecef 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            overflow-x: hidden;
        }
        .form-wrapper {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .account-form-card {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(15px);
            border-radius: 25px;
            box-shadow: 0 25px 70px rgba(0, 0, 0, 0.15);
            padding: 60px 40px;
            max-width: 480px;
            width: 100%;
            border: 1px solid rgba(255, 255, 255, 0.3);
            position: relative;
            overflow: hidden;
        }
        .account-form-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 6px;
            background: linear-gradient(90deg, #007bff, #28a745, #ffc107, #007bff);
            border-radius: 25px 25px 0 0;
        }
        .form-header {
            text-align: center;
            margin-bottom: 45px;
        }
        .form-icon {
            font-size: 4rem;
            color: #007bff;
            margin-bottom: 20px;
            animation: float 3s ease-in-out infinite;
        }
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }
        .form-title {
            font-size: 2.8rem;
            font-weight: 800;
            color: #1a1a1a;
            margin-bottom: 8px;
            letter-spacing: 1px;
        }
        .form-subtitle {
            color: #6c757d;
            font-size: 1.1rem;
            font-weight: 400;
        }
        .form-floating {
            margin-bottom: 25px;
        }
        .form-floating > .form-control {
            border: 2px solid #e9ecef;
            border-radius: 15px;
            padding: 18px 20px;
            font-size: 1.05rem;
            height: 65px;
            background: rgba(255, 255, 255, 0.9);
            transition: all 0.4s ease;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .form-floating > .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.15), 0 8px 25px rgba(0,123,255,0.1);
            background: white;
            transform: translateY(-2px);
        }
        .form-floating > label {
            color: #495057;
            font-weight: 500;
            padding-left: 8px;
            font-size: 1rem;
        }
        .submit-btn {
            width: 100%;
            height: 65px;
            font-size: 1.25rem;
            font-weight: 700;
            border: none;
            border-radius: 15px;
            background: linear-gradient(145deg, #007bff, #0056b3);
            color: white;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 12px 35px rgba(0, 123, 255, 0.3);
            text-transform: uppercase;
            letter-spacing: 1.5px;
        }
        .submit-btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 45px rgba(0, 123, 255, 0.4);
            background: linear-gradient(145deg, #0056b3, #004085);
        }
        .back-section {
            text-align: center;
            margin-top: 35px;
            padding-top: 30px;
            border-top: 1px solid #e9ecef;
        }
        .back-link {
            color: #007bff !important;
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .back-link:hover {
            color: #0056b3 !important;
            text-decoration: none;
            transform: translateX(-5px);
        }
        @media (max-width: 576px) {
            .account-form-card { padding: 40px 25px; margin: 15px; }
            .form-title { font-size: 2.2rem; }
            .form-icon { font-size: 3.2rem; }
        }
    </style>
</head>
<body>
    <div class="form-wrapper">
        <div class="account-form-card">
            <div class="form-header">
                <i class="fas fa-user-plus form-icon"></i>
                <h1 class="form-title">Create Account</h1>
                
			    <% if(request.getAttribute("message") != null) { %>
			    <div class="alert alert-<%= request.getAttribute("status") %> alert-dismissible fade show" style="border-radius:15px;">
			        <%= request.getAttribute("message") %>
			        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
			    </div>
			    <% } %>
                <p class="form-subtitle">Complete your registration to get started</p>
            </div>

		            <!-- FORM SUBMITS TO AccountCreationServlet (POST) -->
		            <form name="registrationForm" action="CreateAccount" method="post">
		    <div class="form-floating">
		        <input type="text" class="form-control" name="firstname" id="firstName" placeholder="First Name" required>
		        <label for="firstName">First Name</label>
		    </div>
		
		    <div class="form-floating">
		        <input type="text" class="form-control" name="lastname" id="lastName" placeholder="Last Name" required>
		        <label for="lastName">Last Name</label>
		    </div>
		
		    <div class="form-floating">
		        <input type="text" class="form-control" name="username" id="username" placeholder="Username" required>
		        <label for="username">Username</label>
		    </div>
		
		    <div class="form-floating">
		        <input type="password" class="form-control" name="pin" id="pin" placeholder="PIN" maxlength="4" required>
		        <label for="pin">4-Digit PIN</label>
		    </div>
		
		    <button type="submit" class="btn submit-btn">Create My Account</button>
		</form>

<!-- Back link -->
<div class="back-section">
    <a href="index.jsp" class="back-link">
        <i class="fas fa-arrow-left"></i> Back to Home
    </a>
</div>
            
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // PIN - only numbers
        document.getElementById('pin').addEventListener('input', function() {
            this.value = this.value.replace(/[^0-9]/g, '').slice(0, 4);
        });
        // Account number - only numbers
        document.getElementById('accountNo').addEventListener('input', function() {
            this.value = this.value.replace(/[^0-9]/g, '').slice(0, 12);
        });
    </script>
</body>
</html>
