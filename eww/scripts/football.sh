#!/bin/bash

# Football matches script using ESPN API
# Fetches live matches from Premier League and other major leagues

CACHE_FILE="/tmp/eww_football_cache.json"
CACHE_TIME=300  # 5 minutes

# Function to fetch from ESPN API
fetch_from_espn() {
    local league_id=$1
    local league_name=$2
    
    # Fetch and parse
    curl -s -m 15 "https://site.api.espn.com/apis/site/v2/sports/soccer/${league_id}/events?limit=10" 2>/dev/null | \
    jq -r ".events[]? | select(.status.type.state != \"pre\") | 
    {
      title: \"\\(.competitors[1].team.displayName // \"Away\") vs \\(.competitors[0].team.displayName // \"Home\")\",
      competition: \"$league_name\",
      date: (.date | split(\"T\")[0]),
      time: (.date | split(\"T\")[1] | split(\"Z\")[0]),
      status: .status.type.name,
      home_score: (.competitions[0].competitors[0].score // \"-\"),
      away_score: (.competitions[0].competitors[1].score // \"-\"),
      score: \"\\(.competitions[0].competitors[0].score // \"-\") - \\(.competitions[0].competitors[1].score // \"-\")\",
      id: .id
    }" 2>/dev/null
}

# Function to get demo data as fallback
get_demo_data() {
    cat <<'DEMO'
[
  {
    "title": "Manchester City vs Liverpool",
    "competition": "Premier League",
    "date": "2026-05-10",
    "time": "19:30:00",
    "status": "LIVE",
    "score": "2-1"
  },
  {
    "title": "Chelsea vs Tottenham",
    "competition": "Premier League",
    "date": "2026-05-10",
    "time": "20:00:00",
    "status": "IN_PROGRESS",
    "score": "1-1"
  },
  {
    "title": "Arsenal vs Brighton",
    "competition": "Premier League",
    "date": "2026-05-10",
    "time": "15:30:00",
    "status": "SCHEDULED",
    "score": "-"
  }
]
DEMO
}

# Main logic
case "$1" in
    "json")
        # Try to fetch real data, fallback to demo if fails
        result=$(mktemp)
        
        # Try Premier League
        fetch_from_espn "eng.1" "Premier League" > "$result" 2>/dev/null || true
        
        if [ ! -s "$result" ] || grep -q "error" "$result" 2>/dev/null; then
            # Try La Liga
            fetch_from_espn "esp.1" "La Liga" > "$result" 2>/dev/null || true
        fi
        
        if [ ! -s "$result" ] || grep -q "error" "$result" 2>/dev/null; then
            # Try Serie A
            fetch_from_espn "ita.1" "Serie A" > "$result" 2>/dev/null || true
        fi
        
        if [ ! -s "$result" ] || grep -q "error" "$result" 2>/dev/null; then
            # Fallback to demo
            get_demo_data
        else
            # Wrap in array
            echo "["
            cat "$result" | grep -v "^$"
            echo "]"
        fi
        rm -f "$result"
        ;;
    "live")
        curl -s -m 10 "https://site.api.espn.com/apis/site/v2/sports/soccer/eng.1/events" 2>/dev/null | \
        jq -r ".events[]? | select(.status.type.state == \"in\") | 
        \"\\(.competitors[1].team.displayName) vs \\(.competitors[0].team.displayName) - \\(.competitions[0].competitors[0].score)-\\(.competitions[0].competitors[1].score)\"" 2>/dev/null || get_demo_data | jq -r '.[] | select(.status == "LIVE") | "\(.title) - \(.score)"'
        ;;
    *)
        get_demo_data
        ;;
esac
