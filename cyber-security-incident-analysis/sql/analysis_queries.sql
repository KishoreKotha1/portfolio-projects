-- 1. Total events by severity (overall risk view)
SELECT
    severity,
    COUNT(*) AS total_events
FROM security_logs
GROUP BY severity
ORDER BY
    CASE severity
        WHEN 'Critical' THEN 1
        WHEN 'High' THEN 2
        WHEN 'Medium' THEN 3
        WHEN 'Low' THEN 4
        ELSE 5
    END;

-- 2. Top 10 source IPs with most failed logins (possible attackers or misconfigured systems)
SELECT
    src_ip,
    COUNT(*) AS failed_login_attempts
FROM security_logs
WHERE event_type = 'login_failure'
GROUP BY src_ip
ORDER BY failed_login_attempts DESC
LIMIT 10;

-- 3. Users with many failed logins (possible compromised accounts or users struggling)
SELECT
    username,
    COUNT(*) AS failed_logins
FROM security_logs
WHERE event_type = 'login_failure'
GROUP BY username
HAVING COUNT(*) > 5
ORDER BY failed_logins DESC;

-- 4. High/Critical events by country (geo view of serious incidents)
SELECT
    country,
    severity,
    COUNT(*) AS total_events
FROM security_logs
WHERE severity IN ('High', 'Critical')
GROUP BY country, severity
ORDER BY total_events DESC;

-- 5. Suspicious IPs: many failures and zero successes (strong brute-force / scanning signal)
SELECT
    src_ip,
    SUM(CASE WHEN event_type = 'login_failure' THEN 1 ELSE 0 END) AS failed_count,
    SUM(CASE WHEN event_type = 'login_success' THEN 1 ELSE 0 END) AS success_count
FROM security_logs
GROUP BY src_ip
HAVING failed_count >= 10
   AND success_count = 0
ORDER BY failed_count DESC;
