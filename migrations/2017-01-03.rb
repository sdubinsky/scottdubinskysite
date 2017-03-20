"CREATE TABLE blog (
post TEXT,
id SERIAL CONSTRAINT blog_pk PRIMARY KEY,
title VARCHAR(200),
tags TEXT,
uploaded_date DATE);"
