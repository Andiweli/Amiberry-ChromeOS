# ChromeOS-Maustest – Amiberry v8.3.0

Ziel ist zunächst, den offiziellen v8.3.0-Eingabepfad ohne zusätzliche Sonderlogik zu validieren.

## Testreihenfolge

1. **Mauszeiger / Capture**
   - Emulation starten.
   - In das Emulatorfenster klicken.
   - Prüfen, ob der ChromeOS-Zeiger verschwindet und die Maus im Amiga übernommen wird.

2. **Relative Bewegung**
   - Langsame horizontale und vertikale Bewegung.
   - Kleine Kreisbewegungen.
   - Schnelle Richtungswechsel.
   - Auf Aussetzer, Sprünge oder Jitter achten.

3. **Linke Maustaste**
   - einfacher Klick;
   - Doppelklick;
   - Taste 2–3 Sekunden halten;
   - Workbench-Icon bzw. Fenster während gedrückter Taste ziehen.
   - Gerade der letzte Punkt prüft den früheren ChromeOS-`ACTION_UP`-Fehler.

4. **Rechte Maustaste**
   - kurzer Klick;
   - halten und gleichzeitig Maus bewegen.

5. **Mausrad**
   - auf/ab;
   - falls die Maus horizontales Scrollen unterstützt, auch horizontal.

6. **Capture verlassen / wieder aufnehmen**
   - Fokus aus Amiberry herausnehmen;
   - zurückkehren;
   - Maus erneut capturen;
   - prüfen, ob relative Bewegung und Tasten weiter funktionieren.

7. **Fenstergröße / ChromeOS-Modus**
   - maximiert;
   - normales Fenster;
   - falls verwendet: Vollbild.

## Wenn etwas nicht funktioniert

Im Android-Projekt liegt `collect_chromeos_mouse_log.bat`. Damit kann ein gefilterter Logcat-Mitschnitt erstellt werden. Interessant sind insbesondere:

- Pointer-Capture-Aktivierung / Verlust;
- `ACTION_BUTTON_PRESS` / `ACTION_BUTTON_RELEASE`;
- relative Mausquelle;
- SDL-Mouse-Events;
- Fokuswechsel.

Erst mit diesem Log sollte ein weiterer Chromebook-spezifischer Patch erfolgen. So vermeiden wir einen zusätzlichen Workaround, der den bereits upstream reparierten Mauspfad wieder verschlechtert.
