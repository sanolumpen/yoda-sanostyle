#!/usr/bin/env python3
import requests
import json
from bs4 import BeautifulSoup
import os
import sys

CACHE_DIR = os.path.expanduser("~/.cache/eww_football_logos")
os.makedirs(CACHE_DIR, exist_ok=True)

TARGET_LEAGUES = [
    "libertadores", "sudamericana", "liga profesional",
    "primera nacional", "copa argentina", "champions", "mundial"
]

def download_image(url, filename):
    path = os.path.join(CACHE_DIR, filename)
    if not os.path.exists(path):
        try:
            r = requests.get(url, timeout=5)
            if r.status_code == 200:
                with open(path, 'wb') as f:
                    f.write(r.content)
            else:
                return ""
        except:
            return ""
    return path

def main():
    url = "https://www.promiedos.com.ar/"
    headers = {'User-Agent': 'Mozilla/5.0'}
    try:
        resp = requests.get(url, headers=headers, timeout=10)
        soup = BeautifulSoup(resp.text, 'html.parser')
        next_data = soup.find('script', id='__NEXT_DATA__')
        
        if not next_data:
            print(json.dumps([]))
            return
            
        data = json.loads(next_data.string)
        matches_data = data.get('props', {}).get('pageProps', {}).get('data', {})
        output = []
        leagues = matches_data.get('leagues', [])
        for val in leagues:
            if not isinstance(val, dict):
                continue
                
            league_name = val.get('name', '')
            league_id = val.get('id', '')
            league_name_lower = league_name.lower()
            
            # Match target leagues (avoid reservas and femeninos)
            if not any(t in league_name_lower for t in TARGET_LEAGUES):
                continue
            if "reserva" in league_name_lower or "femenino" in league_name_lower or "amateur" in league_name_lower:
                continue
                
            # Promiedos uses API for images
            league_logo_url = f"https://api.promiedos.com.ar/images/league/{league_id}/1"
            league_logo_path = download_image(league_logo_url, f"league_{league_id}.png")
            
            matches = val.get('games', [])
            league_matches = []
            
            for m in matches:
                teams = m.get('teams', [])
                if len(teams) < 2:
                    continue
                
                t1 = teams[0]
                t2 = teams[1]
                
                t1_logo = download_image(f"https://api.promiedos.com.ar/images/team/{t1.get('id')}/1", f"team_{t1.get('id')}.png")
                t2_logo = download_image(f"https://api.promiedos.com.ar/images/team/{t2.get('id')}/1", f"team_{t2.get('id')}.png")
                
                status = m.get('status', {}).get('short_name', '')
                time_disp = m.get('game_time_status_to_display', '')
                if not time_disp or status == 'Prog.':
                    start = m.get('start_time', '')
                    if start:
                        time_disp = start.split(' ')[-1] if ' ' in start else start
                        if len(time_disp) > 5:
                            time_disp = time_disp[:5]
                    else:
                        time_disp = ''
                    
                # Extraemos los goles si el partido esta en juego o finalizado
                score1 = ""
                score2 = ""
                if 'score' in m and m['score']:
                    score1 = m['score'].get('team1', '')
                    score2 = m['score'].get('team2', '')
                elif m.get('winner', -1) != -1 or status in ['Fin', 'MT']:
                    # a veces está en otro lugar
                    pass
                
                score_str = f"{score1} - {score2}" if score1 != "" else ""
                
                yellow1 = ""
                yellow2 = ""
                red1 = ""
                red2 = ""
                
                if 'cards' in m and m['cards']:
                    cards = m['cards']
                    yellow1 = cards.get('team1', {}).get('yellow', '')
                    yellow2 = cards.get('team2', {}).get('yellow', '')
                    red1 = cards.get('team1', {}).get('red', '')
                    red2 = cards.get('team2', {}).get('red', '')
                
                league_matches.append({
                    "team1": t1.get('short_name', t1.get('name')),
                    "team1_logo": t1_logo,
                    "team2": t2.get('short_name', t2.get('name')),
                    "team2_logo": t2_logo,
                    "time": time_disp,
                    "status": status,
                    "score": score_str,
                    "yellow1": yellow1,
                    "yellow2": yellow2,
                    "red1": red1,
                    "red2": red2
                })
                
            if league_matches:
                output.append({
                    "league": league_name,
                    "league_logo": league_logo_path,
                    "matches": league_matches
                })
                
        print(json.dumps(output, ensure_ascii=False))
        
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        import traceback
        traceback.print_exc()
        print(json.dumps([]))

if __name__ == "__main__":
    main()
