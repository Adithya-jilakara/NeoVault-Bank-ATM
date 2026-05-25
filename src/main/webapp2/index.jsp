
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to NeoVault Bank</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body, html {
            height: 100vh;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            overflow-x: hidden;
        }
        .bg-container {
            background-image: url('white-bg.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            position: relative;
            min-height: 100vh;
        }
        .bg-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(5px);
        }
        .main-content {
            position: relative;
            z-index: 10;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 40px 20px;
            text-align: center;
        }
        .bank-logo {
            font-size: 4rem;
            color: #007bff;
            margin-bottom: 20px;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        .welcome-heading {
            font-size: clamp(2.5rem, 5vw, 4rem);
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 50px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
            letter-spacing: 2px;
        }
        .options-panel {
            display: flex;
            flex-direction: column;
            gap: 30px;
            max-width: 500px;
            width: 100%;
        }
        .bank-btn {
            height: 70px;
            font-size: 1.4rem;
            font-weight: 600;
            border: none;
            border-radius: 15px;
            transition: all 0.4s ease;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            position: relative;
            overflow: hidden;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .bank-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
            transition: left 0.5s;
        }
        .bank-btn:hover::before {
            left: 100%;
        }
        .bank-btn:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
        }
        .create-account {
            background: linear-gradient(145deg, #28a745, #20c997);
            color: white;
        }
        .create-account:hover {
            box-shadow: 0 20px 40px rgba(40, 167, 69, 0.4);
            color: white;
        }
        .enter-atm {
            background: linear-gradient(145deg, #007bff, #0056b3);
            color: white;
        }
        .enter-atm:hover {
            box-shadow: 0 20px 40px rgba(0, 123, 255, 0.4);
            color: white;
        }
        .btn-icon {
            margin-right: 12px;
        }
        .footer-note {
            margin-top: 60px;
            color: #6c757d;
            font-size: 1rem;
        }
        @media (min-width: 768px) {
            .options-panel {
                flex-direction: row;
                justify-content: center;
            }
            .bank-btn {
                width: 220px;
            }
        }
	        .alert {
	    padding: 15px;
	    margin: 20px 0;
	    border: 1px solid transparent;
	    border-radius: 4px;
	   }
	   .alert-success {
	    color: #3c763d;
	    background-color: #dff0d8;
	    border-color: #d6e9c6;
	    }
	    .alert-error {
	    color: #a94442;
	    background-color: #f2dede;
	    border-color: #ebccd1;
	    }
        
    </style>
</head>
<body>
    <div class="bg-container">
        <div class="bg-overlay"></div>
        <div class="main-content">
            <i class="fas fa-university bank-logo"></i>
            <h1 class="welcome-heading">Welcome to NeoVault Bank</h1>
            
            <!-- ✅ INSERT HERE - Top of page, after <body> -->
	    <% if(request.getAttribute("message") != null) { %>
	    <div class="alert alert-<%= request.getAttribute("status") %>">
	        <%= request.getAttribute("message") %>
	    </div>
	    <% } %>
            
           <!-- DELETE everything from line with <form action="AtmSimulator"... to the next comment -->
<!-- REPLACE WITH THIS SINGLE BLOCK: -->
			<div style="gap: 30px; display: flex; flex-direction: column; align-items: center;">
			    <!-- Create Account -->
			    <a href="createacc.jsp" class="bank-btn create-account" 
			       style="display:inline-block; text-decoration:none; width:220px; text-align:center; line-height:70px;">
			        <i class="fas fa-user-plus btn-icon"></i>
			        Create Account
			    </a>
			    
				 <a href="atmpin.jsp" class="bank-btn enter-atm" 
	                  style="display:inline-block; text-decoration:none; width:220px; text-align:center; line-height:70px;">
	                  <i class="fas fa-credit-card btn-icon"></i>
	                  Enter ATM
	                  </a>

			</div>
           
            <p class="footer-note">Secure Banking at Your Fingertips</p>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
