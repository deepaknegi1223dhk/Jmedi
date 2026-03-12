-- v3: Email template management
CREATE TABLE IF NOT EXISTS email_templates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    template_name VARCHAR(120) NOT NULL UNIQUE,
    subject VARCHAR(255) NOT NULL,
    body LONGTEXT NOT NULL,
    variables TEXT NULL,
    status TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO email_templates (template_name, subject, body, variables, status)
VALUES
('appointment_confirmed',
 'Appointment Confirmed - {{clinic_name}}',
 '<!doctype html><html><body style="margin:0;padding:0;background-color:#f2f5f8;font-family:Arial,Helvetica,sans-serif;"><table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%" style="background-color:#f2f5f8;margin:0;padding:0;"><tr><td align="center" style="padding:20px 10px;"><table role="presentation" cellpadding="0" cellspacing="0" border="0" width="600" style="width:100%;max-width:600px;background-color:#ffffff;border-radius:12px;overflow:hidden;"><tr><td style="padding:14px 20px;background-color:#0f6f90;color:#ffffff;font-size:18px;font-weight:bold;">JMedi Smart Medical Platform</td></tr><tr><td><table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%"><tr><td width="60%" valign="top" style="width:60%;padding:26px 22px;background-color:#eef4f7;"><div style="font-size:30px;line-height:34px;color:#0f7288;font-weight:800;letter-spacing:0.5px;margin-bottom:14px;">Appointment Confirmed</div><div style="font-size:28px;line-height:36px;color:#1f2d3d;margin-bottom:14px;">Dear {{patient_name}},</div><div style="font-size:22px;line-height:34px;color:#1f2d3d;margin-bottom:18px;">Your appointment with <strong>{{doctor_name}}</strong> has been confirmed.</div><table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%" style="background-color:#e9eef3;border-radius:8px;"><tr><td style="padding:15px;border-radius:8px;"><div style="font-size:34px;line-height:40px;color:#1f2d3d;"><strong>Date:</strong> {{appointment_date}}</div><div style="font-size:34px;line-height:40px;color:#1f2d3d;margin-top:6px;"><strong>Time:</strong> {{appointment_time}}</div></td></tr></table><div style="font-size:22px;line-height:34px;color:#1f2d3d;margin-top:18px;">Thank you,<br>{{clinic_name}}</div></td><td width="40%" valign="middle" align="center" style="width:40%;padding:26px 14px;background-color:#1fa2a6;"><table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%" style="max-width:220px;background-color:#ffffff;border-radius:14px;"><tr><td align="center" style="padding:20px 12px 10px 12px;"><img src="{{clinic_logo}}" alt="{{clinic_name}} logo" width="120" style="display:block;border:0;outline:none;text-decoration:none;max-width:120px;height:auto;margin:0 auto 10px auto;"><div style="font-size:44px;line-height:48px;color:#0f4e75;font-weight:800;">JMedi</div><div style="font-size:16px;line-height:22px;color:#0f7288;">Smart Medical Platform</div></td></tr><tr><td align="center" style="padding:12px;background-color:#18828a;color:#ffffff;font-size:16px;line-height:20px;border-bottom-left-radius:14px;border-bottom-right-radius:14px;">Powered by JNVWeb</td></tr></table></td></tr></table></td></tr><tr><td align="center" style="padding:12px 16px;background-color:#f0f3f6;color:#667085;font-size:12px;line-height:18px;">&copy; {{year}} JMedi – Smart Medical Platform</td></tr></table></td></tr></table></body></html>',
 'patient_name,doctor_name,appointment_date,appointment_time,clinic_name,clinic_logo,year',
 1),
('appointment_cancelled', 'Appointment Cancelled - {{clinic_name}}', '<p>Dear {{patient_name}},</p><p>Your appointment with <strong>{{doctor_name}}</strong> has been cancelled.</p><div style="background:#f6f8fb;border:1px solid #d9e2ec;border-radius:8px;padding:15px;"><p><strong>Date:</strong> {{appointment_date}}</p><p><strong>Time:</strong> {{appointment_time}}</p></div><p>Please contact support to reschedule.</p><p>Regards,<br>{{clinic_name}}</p>', 'patient_name,doctor_name,appointment_date,appointment_time,clinic_name', 1),
('doctor_approved', 'Doctor Profile Approved - {{clinic_name}}', '<p>Dear {{doctor_name}},</p><p>Your doctor profile has been approved and is now active.</p><p>Regards,<br>{{clinic_name}}</p>', 'doctor_name,clinic_name', 1),
('payment_success', 'Payment Successful - {{clinic_name}}', '<p>Dear {{patient_name}},</p><p>Your payment has been received successfully.</p><p>Amount: <strong>{{amount}}</strong></p><p>Regards,<br>{{clinic_name}}</p>', 'patient_name,amount,clinic_name', 1),
('patient_registration', 'Welcome to {{clinic_name}}', '<p>Dear {{patient_name}},</p><p>Your registration is successful.</p><p>Regards,<br>{{clinic_name}}</p>', 'patient_name,clinic_name', 1),
('password_reset', 'Password Reset Request - {{clinic_name}}', '<p>Hello {{patient_name}},</p><p>Use this link to reset your password:</p><p><a href="{{reset_link}}">Reset Password</a></p><p>If you did not request this, ignore this email.</p><p>Regards,<br>{{clinic_name}}</p>', 'patient_name,reset_link,clinic_name', 1)
ON DUPLICATE KEY UPDATE
    subject = VALUES(subject),
    body = VALUES(body),
    variables = VALUES(variables),
    status = VALUES(status),
    updated_at = CURRENT_TIMESTAMP;
