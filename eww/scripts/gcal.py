#!/usr/bin/env python3
import os
import sys
import pickle
import json
from datetime import datetime, timedelta, timezone
from google.auth.transport.requests import Request
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build

SCOPES      = ['https://www.googleapis.com/auth/calendar.readonly']
CREDS_FILE  = os.path.expanduser('~/.config/eww/scripts/credentials.json')
TOKEN_FILE  = os.path.expanduser('~/.config/eww/scripts/token.pickle')

def get_service():
    creds = None
    if os.path.exists(TOKEN_FILE):
        with open(TOKEN_FILE, 'rb') as f:
            creds = pickle.load(f)
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(CREDS_FILE, SCOPES)
            creds = flow.run_local_server(port=0)
        with open(TOKEN_FILE, 'wb') as f:
            pickle.dump(creds, f)
    return build('calendar', 'v3', credentials=creds)

def get_today_events():
    service = get_service()
    now   = datetime.now(timezone.utc)
    start = now.replace(hour=0,  minute=0,  second=0,  microsecond=0).isoformat()
    end   = now.replace(hour=23, minute=59, second=59, microsecond=0).isoformat()
    result = service.events().list(
        calendarId='primary', timeMin=start, timeMax=end,
        singleEvents=True, orderBy='startTime'
    ).execute()
    unahur_keywords = ['videojuegos', 'parcial mpi', 'parcial ialypc', 'lógica', 'logica', 'matemática', 'matematica']
    output = []
    for e in result.get('items', []):
        title_lower = e.get('summary', '').lower()
        if any(k in title_lower for k in unahur_keywords):
            continue
        start_raw = e['start'].get('dateTime', e['start'].get('date', ''))
        try:
            t = datetime.fromisoformat(start_raw.replace('Z', '+00:00'))
            time_str = t.astimezone().strftime('%H:%M')
        except:
            time_str = 'Todo el día'
        output.append({'time': time_str, 'title': e.get('summary', 'Sin título')})
    print(json.dumps(output, ensure_ascii=False))

def get_week_events():
    service = get_service()
    now   = datetime.now(timezone.utc)
    start = now.replace(hour=0, minute=0, second=0, microsecond=0)
    end   = start + timedelta(days=7)
    result = service.events().list(
        calendarId='primary', timeMin=start.isoformat(), timeMax=end.isoformat(),
        singleEvents=True, orderBy='startTime'
    ).execute()
    unahur_keywords = ['videojuegos', 'parcial mpi', 'parcial ialypc', 'lógica', 'logica', 'matemática', 'matematica']
    output = []
    for e in result.get('items', []):
        title_lower = e.get('summary', '').lower()
        if any(k in title_lower for k in unahur_keywords):
            continue
        start_raw = e['start'].get('dateTime', e['start'].get('date', ''))
        try:
            t = datetime.fromisoformat(start_raw.replace('Z', '+00:00'))
            day_str  = t.astimezone().strftime('%a %d')
            time_str = t.astimezone().strftime('%H:%M')
        except:
            day_str  = start_raw
            time_str = ''
        output.append({'day': day_str, 'time': time_str, 'title': e.get('summary', 'Sin título')})
    print(json.dumps(output, ensure_ascii=False))

def get_days_with_events(year, month):
    import calendar
    service  = get_service()
    last_day = calendar.monthrange(int(year), int(month))[1]
    start    = datetime(int(year), int(month), 1, tzinfo=timezone.utc)
    end      = datetime(int(year), int(month), last_day, 23, 59, 59, tzinfo=timezone.utc)
    result   = service.events().list(
        calendarId='primary', timeMin=start.isoformat(), timeMax=end.isoformat(),
        singleEvents=True, orderBy='startTime'
    ).execute()
    days = set()
    for e in result.get('items', []):
        start_raw = e['start'].get('dateTime', e['start'].get('date', ''))
        try:
            t = datetime.fromisoformat(start_raw.replace('Z', '+00:00'))
            days.add(t.day)
        except:
            pass
    print(json.dumps(sorted(list(days))))

def get_next_event():
    service = get_service()
    now = datetime.now(timezone.utc)
    end = now.replace(hour=23, minute=59, second=59)
    result = service.events().list(
        calendarId='primary', timeMin=now.isoformat(), timeMax=end.isoformat(),
        maxResults=1, singleEvents=True, orderBy='startTime'
    ).execute()
    events = result.get('items', [])
    if not events:
        print('')
        return
    e         = events[0]
    start_raw = e['start'].get('dateTime', e['start'].get('date', ''))
    try:
        t        = datetime.fromisoformat(start_raw.replace('Z', '+00:00'))
        time_str = t.astimezone().strftime('%H:%M')
    except:
        time_str = ''
    print(f' {time_str} {e.get("summary","Sin título")[:25]}')


def get_independiente_fixtures():
    service = get_service()
    now   = datetime.now(timezone.utc)
    end   = now + timedelta(days=30)
    result = service.events().list(
        calendarId='mseov58djcsk7hlri7d0n8ngkg@group.calendar.google.com',
        timeMin=now.isoformat(),
        timeMax=end.isoformat(),
        singleEvents=True,
        orderBy='startTime',
        maxResults=5
    ).execute()
    output = []
    for e in result.get('items', []):
        start_raw = e['start'].get('dateTime', e['start'].get('date', ''))
        try:
            t        = datetime.fromisoformat(start_raw.replace('Z', '+00:00'))
            day_str  = t.astimezone().strftime('%a %d/%m')
            time_str = t.astimezone().strftime('%H:%M')
        except:
            day_str  = start_raw
            time_str = ''
        output.append({
            'day':   day_str,
            'time':  time_str,
            'title': e.get('summary', 'Independiente')
        })
    print(json.dumps(output, ensure_ascii=False))


def get_unahur_today():
    service = get_service()
    now   = datetime.now(timezone.utc)
    start = now.replace(hour=0, minute=0, second=0, microsecond=0).isoformat()
    end   = now.replace(hour=23, minute=59, second=59).isoformat()
    output = []
    for cal_id in [
        '824566ef81acde362f125a1a550047e434a1153f2cb9b5f96b3c2e041173103e@group.calendar.google.com',
        '80ul5oblsp9sl0i31n28e5q4d5fa51fb@import.calendar.google.com'
    ]:
        result = service.events().list(
            calendarId=cal_id, timeMin=start, timeMax=end,
            singleEvents=True, orderBy='startTime'
        ).execute()
        for e in result.get('items', []):
            start_raw = e['start'].get('dateTime', e['start'].get('date', ''))
            try:
                t = datetime.fromisoformat(start_raw.replace('Z', '+00:00'))
                time_str = t.astimezone().strftime('%H:%M')
            except:
                time_str = 'Todo el día'
            output.append({'time': time_str, 'title': e.get('summary', 'Sin título')})
    output.sort(key=lambda x: x['time'])
    print(json.dumps(output, ensure_ascii=False))

def get_unahur_week():
    service = get_service()
    now   = datetime.now(timezone.utc)
    # Empezar desde mañana para no duplicar con unahur_today
    start = now.replace(hour=0, minute=0, second=0, microsecond=0) + timedelta(days=1)
    end   = now.replace(hour=0, minute=0, second=0, microsecond=0) + timedelta(days=7)
    output = []
    for cal_id in [
        '824566ef81acde362f125a1a550047e434a1153f2cb9b5f96b3c2e041173103e@group.calendar.google.com',
        '80ul5oblsp9sl0i31n28e5q4d5fa51fb@import.calendar.google.com'
    ]:
        result = service.events().list(
            calendarId=cal_id, timeMin=start.isoformat(), timeMax=end.isoformat(),
            singleEvents=True, orderBy='startTime'
        ).execute()
        for e in result.get('items', []):
            start_raw = e['start'].get('dateTime', e['start'].get('date', ''))
            try:
                t = datetime.fromisoformat(start_raw.replace('Z', '+00:00'))
                day_str  = t.astimezone().strftime('%a %d')
                time_str = t.astimezone().strftime('%H:%M')
            except:
                day_str  = start_raw
                time_str = ''
            output.append({'day': day_str, 'time': time_str, 'title': e.get('summary', 'Sin título')})
    output.sort(key=lambda x: (x['day'], x['time']))
    print(json.dumps(output, ensure_ascii=False))

def get_unahur_upcoming():
    """Entregas/vencimientos — eventos con horario 00:00 o keywords"""
    service = get_service()
    now   = datetime.now(timezone.utc)
    end   = now + timedelta(days=30)
    output = []
    for cal_id in [
        '824566ef81acde362f125a1a550047e434a1153f2cb9b5f96b3c2e041173103e@group.calendar.google.com',
        '80ul5oblsp9sl0i31n28e5q4d5fa51fb@import.calendar.google.com'
    ]:
        result = service.events().list(
            calendarId=cal_id,
            timeMin=now.isoformat(), timeMax=end.isoformat(),
            singleEvents=True, orderBy='startTime'
        ).execute()
        for e in result.get('items', []):
            start_raw = e['start'].get('dateTime', e['start'].get('date', ''))
            try:
                t = datetime.fromisoformat(start_raw.replace('Z', '+00:00'))
                time_str = t.astimezone().strftime('%H:%M')
                day_str  = t.astimezone().strftime('%a %d/%m')
            except:
                time_str = '00:00'
                day_str  = start_raw
            # Entregas = solo eventos con keywords de vencimiento en el título
            keywords = ['vencimiento', 'se cierra', 'entrega', 'parcial', 'tp', 'examen', 'final']
            title_lower = e.get('summary', '').lower()
            if any(k in title_lower for k in keywords):
                output.append({'day': day_str, 'time': time_str, 'title': e.get('summary', 'Sin título')})
    output.sort(key=lambda x: x['day'])
    print(json.dumps(output, ensure_ascii=False))

def get_unahur_classes():
    """Solo clases — eventos con horario distinto de 00:00"""
    service = get_service()
    now   = datetime.now(timezone.utc)
    end   = now + timedelta(days=7)
    output = []
    for cal_id in [
        '824566ef81acde362f125a1a550047e434a1153f2cb9b5f96b3c2e041173103e@group.calendar.google.com',
        '80ul5oblsp9sl0i31n28e5q4d5fa51fb@import.calendar.google.com'
    ]:
        result = service.events().list(
            calendarId=cal_id,
            timeMin=now.isoformat(), timeMax=end.isoformat(),
            singleEvents=True, orderBy='startTime'
        ).execute()
        for e in result.get('items', []):
            start_raw = e['start'].get('dateTime', e['start'].get('date', ''))
            try:
                t = datetime.fromisoformat(start_raw.replace('Z', '+00:00'))
                time_str = t.astimezone().strftime('%H:%M')
                day_str  = t.astimezone().strftime('%a %d')
            except:
                time_str = '00:00'
                day_str  = start_raw
            if time_str != '00:00':
                output.append({'day': day_str, 'time': time_str, 'title': e.get('summary', 'Sin título')})
    # Agregar desde primary los eventos de materias UNAHUR
    unahur_primary_keywords = ['videojuegos', 'parcial mpi', 'parcial ialypc', 'lógica', 'logica', 'matemática', 'matematica']
    now2 = datetime.now(timezone.utc)
    end2 = now2 + timedelta(days=7)
    result2 = service.events().list(
        calendarId='primary',
        timeMin=now2.isoformat(), timeMax=end2.isoformat(),
        singleEvents=True, orderBy='startTime'
    ).execute()
    for e in result2.get('items', []):
        title_lower = e.get('summary', '').lower()
        if any(k in title_lower for k in unahur_primary_keywords):
            start_raw = e['start'].get('dateTime', e['start'].get('date', ''))
            try:
                t = datetime.fromisoformat(start_raw.replace('Z', '+00:00'))
                time_str = t.astimezone().strftime('%H:%M')
                day_str  = t.astimezone().strftime('%a %d')
            except:
                time_str = '00:00'
                day_str  = start_raw
            if time_str != '00:00':
                output.append({'day': day_str, 'time': time_str, 'title': e.get('summary', 'Sin título')})
    output.sort(key=lambda x: (x['day'], x['time']))
    print(json.dumps(output, ensure_ascii=False))


def get_day_events(date_str):
    """Eventos de un día específico — formato YYYY-MM-DD"""
    service = get_service()
    from datetime import datetime, timezone
    try:
        day = datetime.strptime(date_str, '%Y-%m-%d').replace(tzinfo=timezone.utc)
    except:
        print('[]')
        return
    start = day.replace(hour=0, minute=0, second=0).isoformat()
    end   = day.replace(hour=23, minute=59, second=59).isoformat()
    output = []
    for cal_id in [
        'primary',
        '824566ef81acde362f125a1a550047e434a1153f2cb9b5f96b3c2e041173103e@group.calendar.google.com',
        '80ul5oblsp9sl0i31n28e5q4d5fa51fb@import.calendar.google.com',
        'mseov58djcsk7hlri7d0n8ngkg@group.calendar.google.com'
    ]:
        result = service.events().list(
            calendarId=cal_id, timeMin=start, timeMax=end,
            singleEvents=True, orderBy='startTime'
        ).execute()
        for e in result.get('items', []):
            start_raw = e['start'].get('dateTime', e['start'].get('date', ''))
            try:
                t = datetime.fromisoformat(start_raw.replace('Z', '+00:00'))
                time_str = t.astimezone().strftime('%H:%M')
            except:
                time_str = 'Todo el día'
            output.append({'time': time_str, 'title': e.get('summary', 'Sin título')})
    output.sort(key=lambda x: x['time'])
    print(json.dumps(output, ensure_ascii=False))

if __name__ == '__main__':
    cmd = sys.argv[1] if len(sys.argv) > 1 else 'today'
    if   cmd == 'today': get_today_events()
    elif cmd == 'week':  get_week_events()
    elif cmd == 'days':  get_days_with_events(sys.argv[2], sys.argv[3])
    elif cmd == "next":  get_next_event()
    elif cmd == "indie":    get_independiente_fixtures()
    elif cmd == "unahur_today":  get_unahur_today()
    elif cmd == "unahur_week":   get_unahur_week()
    elif cmd == "unahur_upcoming": get_unahur_upcoming()
    elif cmd == "unahur_classes":  get_unahur_classes()
    elif cmd == "day":     get_day_events(sys.argv[2] if len(sys.argv) > 2 else "")

def list_calendars():
    service = get_service()
    result = service.calendarList().list().execute()
    for cal in result.get('items', []):
        print(f"{cal['id']} — {cal['summary']}")


