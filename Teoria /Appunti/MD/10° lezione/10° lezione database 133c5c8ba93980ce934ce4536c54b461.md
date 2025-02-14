# 10° lezione database

Materia: Database
REVISIONATA : No
Status: Done

# Introduzione a MySQL

## Funzioni

![Screenshot 2024-11-08 at 13.50.35.png](10%C2%B0%20lezione%20database%20133c5c8ba93980ce934ce4536c54b461/Screenshot_2024-11-08_at_13.50.35.png)

![Screenshot 2024-11-08 at 13.50.54.png](10%C2%B0%20lezione%20database%20133c5c8ba93980ce934ce4536c54b461/Screenshot_2024-11-08_at_13.50.54.png)

![Screenshot 2024-11-08 at 13.51.28.png](10%C2%B0%20lezione%20database%20133c5c8ba93980ce934ce4536c54b461/Screenshot_2024-11-08_at_13.51.28.png)

## Operatori

![Screenshot 2024-11-08 at 13.52.09.png](10%C2%B0%20lezione%20database%20133c5c8ba93980ce934ce4536c54b461/Screenshot_2024-11-08_at_13.52.09.png)

![Screenshot 2024-11-08 at 13.52.21.png](10%C2%B0%20lezione%20database%20133c5c8ba93980ce934ce4536c54b461/Screenshot_2024-11-08_at_13.52.21.png)

## Controllo del flusso

```sql
CASE value
	WHEN compare_value THEN result
	[WHEN compare_value THEN result ...]
	[ELSE result]
END
```

```sql
CASE
END
	WHEN condition THEN result
	[WHEN condition THEN result ...]
	[ELSE result]
END 
```

```sql
IF(expr1,expr2,expr3)
IFNULL(expr1,expr2)
NULLIF(expr1,expr2)
```

## Esempio Controllo del flusso

```sql
SELECT film_id, title,
CASE rating
	WHEN 'G' THEN 'General Audiences"
	WHEN 'PG' THEN 'Parental Guidance Suggested'
	WHEN 'PG-13' THEN 'Parents Strongly Cautioned'
	WHEN 'R' THEN 'Restricted'
	WHEN 'NC-17' THEN 'No one 17 and under admitted'
	ELSE 'There is nothing else'
END AS ExplainedRating,
IF (STRCMP (rating, 'NC-17')=0, 'YES', 'no') AS RequireID FROM film;
```

## Funzioni su stringhe

![Screenshot 2024-11-08 at 13.56.44.png](10%C2%B0%20lezione%20database%20133c5c8ba93980ce934ce4536c54b461/Screenshot_2024-11-08_at_13.56.44.png)

![Screenshot 2024-11-08 at 13.57.14.png](10%C2%B0%20lezione%20database%20133c5c8ba93980ce934ce4536c54b461/Screenshot_2024-11-08_at_13.57.14.png)

![Screenshot 2024-11-08 at 13.57.37.png](10%C2%B0%20lezione%20database%20133c5c8ba93980ce934ce4536c54b461/Screenshot_2024-11-08_at_13.57.37.png)

![Screenshot 2024-11-08 at 13.57.47.png](10%C2%B0%20lezione%20database%20133c5c8ba93980ce934ce4536c54b461/Screenshot_2024-11-08_at_13.57.47.png)

![Screenshot 2024-11-08 at 13.58.20.png](10%C2%B0%20lezione%20database%20133c5c8ba93980ce934ce4536c54b461/Screenshot_2024-11-08_at_13.58.20.png)

```sql
SELECT C. customer_id,
	CONCAT (C. first_name,
	', C. last_name) AS name,
	CONCAT_WS (', ', A.address, IF (STRCMP (A.address2,'')=0, NULL, A.address2)) AS address,
	A.postal_code, A.phone, CI.city, co.country
FROM
customer AS C
	JOIN address AS A ON A.address_id = C. address_id
	JOIN city AS CI ON CI. city_id = A.city_id
	JOIN country AS CO ON CO.country_id = CI.country_id
WHERE active <> 0;
```