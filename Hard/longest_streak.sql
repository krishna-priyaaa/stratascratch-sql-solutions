--ID 2059

with ordered_matches as (select
    player_id, match_date, match_result,
    case when match_result = 'W' and
    lag(match_result) over (partition by player_id order by match_date) <> 'W'
        then 1 else 0 end as is_new_streak
    from players_results
),
streaks as (select
    player_id, match_date, match_result,
    sum(is_new_streak) over (partition by player_id order by match_date) as streak_id
    from ordered_matches
),
stats as(
select player_id, max(c) as streak from(
select player_id, streak_id, count(*) as c from streaks where match_result = 'W' group by 1,2) a group by 1)
select * from stats where streak = (select max(streak) from stats)


