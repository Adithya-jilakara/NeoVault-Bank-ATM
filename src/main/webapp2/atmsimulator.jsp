<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.myatm.model.AccountinfoModel"%>
<%@page import="com.myatm.dao.AccountDAO"%>
<%@page import="jakarta.servlet.http.HttpSession"%>

<%
    HttpSession ses = request.getSession();
    String message = (String) ses.getAttribute("message");
    String error = (String) ses.getAttribute("error");
    
    if(message != null) {
        out.println("<div style='color:green; padding:10px; border:1px solid green; margin:10px; background:#d4edda;'>"+message+"</div>");
        ses.removeAttribute("message");
    }
    if(error != null) {
        out.println("<div style='color:red; padding:10px; border:1px solid red; margin:10px; background:#f8d7da;'>"+error+"</div>");
        ses.removeAttribute("error");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NeoVault Bank ATM </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --atm-green: #00ff41;
            --atm-dark: #0a0a0a;
            --red-btn: #dc3545;
            --red-hover: #c82333;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
		        
		 
        
        body {
            background: var(--atm-dark);
            color: var(--atm-green);
            font-family: 'Courier New', monospace;
            height: 100vh;
            overflow: hidden;
        }
        
        /* Header with Home Button - Top Right */
        .header {
            background: linear-gradient(90deg, #000, #111);
            border-bottom: 4px solid var(--atm-green);
            height: 80px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 30px;
            box-shadow: 0 0 40px var(--atm-green);
        }
        .header-title { font-size: 28px; }
        
        /* Main Container - Bootstrap Fluid */
		.main-container {
		    height: calc(100vh - 80px - 20px);
		    padding: 10px 15px !important;
		    overflow: hidden;
		    display: flex;
		    align-items: stretch;  /* CRITICAL */
		   }
				 
		        
        
        /* Button Panels - Col-2 each */
		.btn-panel {
	    background: rgba(10,10,10,0.95);
	    border: 4px solid #00ff41 !important;
	    border-radius: 25px;
	    padding: 15px !important;
	    height: 480px;
	    display: flex;
	    flex-direction: column;
	    gap: 0 !important;              /* NO gaps between buttons */
	    justify-content: center;
	    box-shadow: 0 0 30px rgba(0,255,65,0.5);
	    margin: 0 !important;
	    position: relative;
	    }
		    
        
        
        /* ATM Display Screen - Col-6 (4-9 sections) */
	    .atm-screen {
		    background: linear-gradient(145deg, #000, #111);
		    border: 12px solid #00ff41 !important;
		    border-radius: 40px;
		    height: 500px;
		    position: relative;
		    box-shadow: 0 0 100px #00ff41, inset 0 0 60px rgba(0,255,65,0.1);
		    margin: 0 !important;           /* NO margins */
		    padding: 0 !important;          /* NO padding */
		    width: 100%;
		    box-sizing: border-box;         /* Border INCLUDES in height */
		  }
		 
		  
		 
        
        
        /* RED ATM BUTTONS */
        .atm-btn {
            height: 70px;
            background: linear-gradient(145deg, var(--red-btn), var(--red-hover));
            color: white !important;
            border: 4px solid #a71e2a;
            border-radius: 20px;
            font-size: 16px;
            font-weight: bold;
            font-family: 'Courier New', monospace;
            text-transform: uppercase;
            transition: all 0.4s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        .atm-btn:hover {
            background: linear-gradient(145deg, #e74a5a, var(--red-btn));
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(220,53,69,0.7);
            border-color: #c82333;
        }
        
        
        .home-btn {
            width: 200px;
            height: 80px;
            background: linear-gradient(145deg, var(--red-btn), var(--red-hover));
            color: white !important;
            border: 4px solid #a71e2a;
            border-radius: 20px;
            font-size: 18px;
            font-weight: bold;
            font-family: 'Courier New', monospace;
            text-transform: uppercase;
            text-decoration: none;
            transition: all 0.4s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }
        .home-btn:hover {
            background: linear-gradient(145deg, #e74a5a, var(--red-btn));
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(220,53,69,0.7);
            border-color: #c82333;
            color: white !important;
        }
        
        /* Screen Content */
        .screen-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 90%;
            height: 85%;
            background: rgba(0,15,0,0.98);
            border: 6px solid var(--atm-green);
            border-radius: 30px;
            padding: 40px;
            text-align: center;
            display: none;
            overflow-y: auto;
        }
        .screen-content.active { display: block !important; }
        
        .screen-title { 
            font-size: 36px; 
            text-shadow: 0 0 40px var(--atm-green);
            margin-bottom: 30px;
        }
        
        .input-field {
            width: 100%;
            max-width: 400px;
            height: 80px;
            font-size: 36px;
            text-align: center;
            border: 6px solid var(--atm-green);
            background: #000;
            color: var(--atm-green);
            border-radius: 25px;
            margin: 25px 0;
            font-family: 'Courier New';
        }
        
        .balance-display {
            font-size: 64px;
            color: #00ff88;
            text-shadow: 0 0 60px var(--atm-green);
            margin: 40px 0;
            animation: glow 2s infinite;
        }
        @keyframes glow {
            0%, 100% { text-shadow: 0 0 60px var(--atm-green); }
            50% { text-shadow: 0 0 100px var(--atm-green); }
        }
        
        .status-msg {
            background: rgba(0,255,65,0.25);
            border: 3px solid var(--atm-green);
            padding: 20px;
            border-radius: 15px;
            margin: 25px 0;
            font-size: 20px;
        }
        .error-msg {
            background: rgba(220,53,69,0.25);
            border-color: var(--red-btn);
            color: #ff6b7a;
        }
        
        .welcome-name {
            font-size: 56px;
            color: #00ff88;
            text-shadow: 0 0 60px var(--atm-green);
            margin: 50px 0;
            line-height: 1.1;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <!-- FIXED SESSION CHECK - UNCHANGED -->
		<%
		AccountinfoModel user = (AccountinfoModel) session.getAttribute("currentUser");
		String firstName = "";
		String lastName = "";
		Double sessionBalance = (Double) session.getAttribute("currentBalance");
		double currentBalance = (sessionBalance != null) ? sessionBalance : 0.00;
		
		if(user != null) {
		    firstName = user.getFirstname();
		    lastName = user.getLastname();
		} else {
		    response.sendRedirect("atmpin.jsp");
		    return;
		}
		%>

    

    <!-- Header -->
    <div class="header">
        <div class="header-title">
            <i class="fas fa-university"></i> NeoVault Bank ATM
        </div>
        <div></div> <!-- Spacer -->
    </div>
    
    <!-- BOOTSTRAP 12-COLUMN LAYOUT -->
    <div class="main-container">
        <div class="container-fluid">
            <div class="row h-100 align-items-stretch g-2">
                
                <!-- 1st: FREE SPACE (col-1) -->
                <div class="col-1"></div>
                
                <!-- 2nd+3rd: LEFT BUTTONS (col-2) - CANCEL, CLEAR, CHANGE PIN -->
                <div class="col-2">
                    <div class="btn-panel">
                        <button class="atm-btn w-100 mb-2" onclick="showScreen('cancel')">
                            <i class="fas fa-times"></i> CANCEL
                        </button>
                        <button class="atm-btn w-100 mb-2" onclick="showScreen('clear')">
                            <i class="fas fa-eraser"></i> CLEAR
                        </button>
                        <button class="atm-btn w-100" onclick="showScreen('changepin')">
                            <i class="fas fa-key"></i> CHANGE PIN
                        </button>
                    </div>
                </div>
                
                <!-- 4-9th: ATM DISPLAY SCREEN (col-6) - SMALL CONTAINER -->
                <div class="col-6">
                    <div class="atm-screen">
                        <!-- Welcome Screen - MESSAGE ONLY -->
                        <div id="welcomeScreen" class="screen-content active">
                            <div class="screen-title">WELCOME</div>
                            <div class="welcome-name">
                                "<%= firstName %> <%= lastName %>!!!!"
                            </div>
                        </div>
                        
                        <!-- Main Menu -->
                        <div id="menuScreen" class="screen-content">
                            <div class="screen-title">SELECT TRANSACTION</div>
                            <button class="atm-btn w-80 mx-auto mb-3" onclick="showScreen('balance')" style="height: 70px; font-size: 18px;">
                                <i class="fas fa-eye me-2"></i> BALANCE
                            </button>
                            <button class="atm-btn w-80 mx-auto mb-3" onclick="showScreen('withdraw')" style="height: 70px; font-size: 18px;">
                                <i class="fas fa-minus me-2"></i> WITHDRAW
                            </button>
                            <button class="atm-btn w-80 mx-auto mb-3" onclick="showScreen('deposit')" style="height: 70px; font-size: 18px;">
                                <i class="fas fa-plus me-2"></i> DEPOSIT
                            </button>
                            <button class="atm-btn w-80 mx-auto" onclick="showScreen('changepin')" style="height: 70px; font-size: 18px;">
                                <i class="fas fa-key me-2"></i> CHANGE PIN
                            </button>
                        </div>
                        
                        <!-- Balance Screen -->
                        <div id="balanceScreen" class="screen-content">
                            <div class="screen-title">ACCOUNT BALANCE</div>
                            <div class="balance-display">₹<%= currentBalance %></div>
                            <div class="status-msg">
                                <i class="fas fa-check-circle me-2"></i> Available Balance
                            </div>
                            
                        </div>
                        
                        <!-- Withdraw Screen -->
                        <div id="withdrawScreen" class="screen-content">
                            <div class="screen-title">WITHDRAW CASH</div>
                            <form id="withdrawForm" action="withdraw" method="post">
						       <input type="number" name="amount" class="input-field" placeholder="Enter Amount" min="100" max="25000" id="withdrawInput">
						       <button type="submit" class="atm-btn w-75 mx-auto mt-3" onclick="return validateWithdraw()" style="height: 70px; font-size: 18px;">
						        WITHDRAW
						       </button>
                            </form>
                            
                           
                        </div>
                        
                        <!-- Deposit Screen -->
                        <div id="depositScreen" class="screen-content">
                            <div class="screen-title">DEPOSIT CASH</div>
                            <form id="depositForm" action="deposit" method="post">
                                <input type="number" name="amount" class="input-field" placeholder="Enter Amount" min="100" max="100000" id="depositInput">
                                <button type="submit" class="atm-btn w-75 mx-auto mt-3" onclick="return validateDeposit()" style="height: 70px; font-size: 18px;">
                                  DEPOSIT
                                </button>

                            </form>
                           
                        </div>
                        
                        <!-- Change PIN Screen -->
                        <!-- Change PIN Screen - UPDATED FOR SERVLET -->
						<div id="changepinScreen" class="screen-content">
						    <div class="screen-title">CHANGE PIN</div>
						    <form id="pinForm" action="changepin" method="post">
						        <input type="password"  name="oldPin" class="input-field" placeholder="Old PIN" maxlength="4" required>
						        <input type="password"  name="newPin" class="input-field"  placeholder="New PIN"  maxlength="4"  required>
						        <button type="submit"  class="atm-btn w-75 mx-auto mt-3" style="height: 70px; font-size: 18px;">
						            <i class="fas fa-key me-2"></i> CHANGE PIN
						        </button>
						    </form>
						</div>
						
						                        
                        <!-- Status Screens -->
                        <div id="cancelScreen" class="screen-content">
                            <div class="screen-title">TRANSACTION CANCELLED</div>
                            <div class="status-msg error-msg">
                                <i class="fas fa-times-circle me-2"></i> Operation Cancelled
                            </div>
                            
                        </div>
                        
                        <div id="clearScreen" class="screen-content">
                            <div class="screen-title">SCREEN CLEARED</div>
                            <div class="status-msg">
                                <i class="fas fa-eraser me-2"></i> Input Cleared
                            </div>
                            
                        </div>
                        
                        <!-- Result Screen -->
                        <div id="resultScreen" class="screen-content">
                            <div class="screen-title" id="resultTitle">TRANSACTION COMPLETE</div>
                            <div class="status-msg" id="resultMsg"></div>

                        </div>
                    </div>
                </div>
                
                <!-- 10-11th: RIGHT BUTTONS (col-2) - WITHDRAW, DEPOSIT, BALANCE -->
                <div class="col-2">
                    
                    <div class="btn-panel">
                     <a href="index.jsp" class="atm-btn w-100 mb-2">
                            <i class="fas fa-home"></i> HOME
                        </a>
                        <button class="atm-btn w-100 mb-2" onclick="showScreen('withdraw')">
                            <i class="fas fa-minus"></i> WITHDRAW
                        </button>
                        <button class="atm-btn w-100 mb-2" onclick="showScreen('deposit')">
                            <i class="fas fa-plus"></i> DEPOSIT
                        </button>
                        <button class="atm-btn w-100" onclick="showScreen('balance')">
                            <i class="fas fa-eye"></i> BALANCE
                        </button>
                    </div>
                </div>
                
                
            </div>
        </div>
    </div>

    <!-- UNCHANGED JAVASCRIPT -->
    <script>
    let currentBalance = <%= currentBalance %>;
    
    function showScreen(screenId) {
        // Hide all screens
        document.querySelectorAll('.screen-content').forEach(screen => {
            screen.classList.remove('active');
        });
        // Show selected screen
        document.getElementById(screenId + 'Screen').classList.add('active');
        // Clear all input fields
        document.querySelectorAll('.input-field').forEach(field => field.value = '');
    }
    
    function validateWithdraw() {  // ✅ FIXED
        let amount = parseFloat(document.getElementById('withdrawInput').value);
        if(amount >= 100 && amount <= 25000 && !isNaN(amount)) {
            document.getElementById('withdrawInput').value = amount;
            return true;
        } else {
            alert('Enter valid amount: ₹100 - ₹25,000');
            return false;
        }
    }
    
    function validateDeposit() {
        let amount = parseFloat(document.getElementById('depositInput').value);
        if(amount >= 100 && amount <= 100000 && !isNaN(amount)) {
            document.getElementById('depositInput').value = amount;
            return true;
        } else {
            alert('Enter valid amount: ₹100 - ₹1,00,000');
            return false;
        }
    }

    
   
</script>

</body>
</html>
