Industry Layoff Analysis:
It all started when I stumbled upon a global layoffs dataset. At first glance, it looked pretty interesting — it had data on companies, industries, countries, when the layoffs happened, how many people were let go, funding stages, and more. But the more I explored it, the more I realized: the data was a mess.
and that’s when I thought — “This is perfect.”

As someone starting out with SQL and data analysis, I knew I wanted hands-on experience with real, messy data. Not just textbook-perfect rows and columns, but the kind of data you'd actually get in the real world — full of duplicates, inconsistent formats, nulls, weird spacing, and columns you don’t even need.

Step 1: Cleaning the Chaos

I began by creating a staging table in MySQL — like a sandbox where I could break things safely. Then I started cleaning:
I tackled duplicates using ROW_NUMBER() and Common Table Expressions (CTEs).
Trimmed all the weird whitespaces and fixed inconsistencies in industry and company names.
Converted string-based dates into proper DATE format.
Replaced blank strings with NULLs and removed rows with missing key data.
Finally, dropped irrelevant columns like source, date_added, and employee name lists — the kind of stuff that just clutters analysis.
This whole cleaning process was like organizing a chaotic spreadsheet into something neat and meaningful. Once I was done, it felt like I had polished the raw data into something analysis-ready.

Step 2: Asking Questions with SQL

With clean data in hand, it was time to explore. I asked myself: what are the most useful or interesting things I could learn from this?

Here are some of the things I analyzed:

-How many people were laid off each month and year?
-Which companies had the most layoffs?
-What industries and countries were hit the hardest?
-Which companies laid off the highest percentage of their staff?
To do this, I used SQL window functions like ROW_NUMBER() and DENSE_RANK(), worked with dates, grouped and ordered things to identify patterns over time — even calculated rolling totals to visualize how layoffs progressed month by month.

Step 3: Insights That Made Me Pause

This part was fascinating. I found that:
1. Some companies actually laid off 100% of their workforce — total shutdowns.
2. Layoffs weren’t randomly distributed — tech, crypto, and startups in specific stages of funding were clearly more vulnerable.
3.There were spikes in layoffs that matched broader economic trends — it wasn’t just one-off events.

Through all this, I wasn’t just learning SQL syntax. I was learning how to think like an analyst: clean the data, ask smart questions, and extract insights that actually matter.

POV:
This wasn’t just a project for my portfolio. It taught me how to work with unstructured data, trust the process of data wrangling, and see the impact of good analysis. And honestly? It was fun. Like solving a real puzzle, one query at a time.
