<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>ATM PIN Entry - NeoVault Bank</title>
    <style>
        body { 
            background: linear-gradient(135deg, #000, #111); 
            color: #00ff41; 
            font-family: 'Courier New', monospace; 
            text-align: center; 
            padding-top: 20vh;
        }
        h1 { font-size: 48px; text-shadow: 0 0 30px #00ff41; margin-bottom: 50px; }
        input[type="password"] { 
            font-size: 48px; 
            width: 250px; 
            height: 100px; 
            border: 4px solid #00ff41; 
            background: #000; 
            color: #00ff41; 
            border-radius: 15px; 
            text-align: center; 
            font-family: 'Courier New';
        }
        button { 
            background: #00ff41; 
            color: #000; 
            border: none; 
            padding: 25px 60px; 
            font-size: 28px; 
            border-radius: 15px; 
            cursor: pointer; 
            margin-top: 40px;
            font-family: 'Courier New';
            font-weight: bold;
        }
        button:hover { background: #00cc33; transform: scale(1.05); }
    </style>
</head>
<body>
    <h1><i class="fas fa-university"></i>NeoVault Bank ATM</h1>
    <form action="AtmSimulator" method="POST">
        <input type="password" name="pin" maxlength="4" placeholder="****" required autofocus><br>
        <button type="submit"><i class="fas fa-arrow-right"></i> ENTER</button>
    </form>
    <p style="margin-top: 50px; font-size: 18px;">
        <a href="index.jsp" style="color: #00ff41;">← Back to Home</a>
    </p>
</body>
</html>
