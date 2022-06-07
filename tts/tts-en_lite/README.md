# Offline TTS (en_lite)

[![Open your Home Assistant instance and show the dashboard of a Supervisor add-on.](https://my.home-assistant.io/badges/supervisor_addon.svg)](https://my.home-assistant.io/redirect/supervisor_addon/?addon=Offline+AI+Hass.IO+Add-Ons&repository_url=https%3A%2F%2Fgithub.com%2Foffline-ai%2Fhassio-addons)

## Settings

* `cache_dir`
    * Directory to cache generated WAV files
    * Leave empty to disable (default, HA already has a TTS cache)
* `log_level`
    * Controls the level of log details the add-on provides.
    * Default is `info`
* `preferred_voices`
    * Preferred voice list for language with [SSML](#ssml), the item:

    ```yaml
    preferred_voices:
      - lang: "zh"
        voice: "tts:zh_baker"
      - lang: "en"
        voice: "tts:en_vctk"
    ```

## Compatible with MaryTTS

Use Offline TTS as a drop-in replacement for [MaryTTS](https://www.home-assistant.io/integrations/marytts/).

Add to your `configuration.yaml` file:

```yaml
tts:
  - platform: marytts
    voice: tts:zh_baker
```

The `voice` format is `<TTS System>:<Voice Name>[#<Speaker ID>`. The `Speaker ID` is optional for multi speakers model only.

The following TTS Engines used:

* [Coqui-TTS](http://coqui.ai/): Patched and embedded version of Coqui-TTS latest dev(0.7.0) version
  * TTS System name: `tts`
  * Voice quality: Good
  * Performance: Not Good, You need a powerful CPU and enough memory
  * Resource overhead: High
  * Builtin Voice Models:
    * `zh_baker`: Chinese Voice from baker [F]
    * `en_vctk`: English Multi Speakers Voice [MF]
* [ESpeaker](http://espeak.sourceforge.net)
  * TTS System name: `espeak`
  * Voice quality: Bad, like robotic.
  * Performance: Very Good
  * Resource overhead: Low
  * Builtin Voice Models:
    * `en-029`: English_(Caribbean) [M]
    * `en-gb`: English_(Great_Britain) [M]
    * `en-gb-scotland`: English_(Scotland) [M]
    * `en-gb-x-gbclan`: English_(Lancaster) [M]
    * `en-gb-x-gbcwmd`: English_(West_Midlands) [M]
    * `en-gb-x-rp`: English_(Received_Pronunciation) [M]
    * `en-us`: English_(America) [M]
    * `zh-cmn`: Chinese_(Mandarin) [M]
    * `zh-yue`: Chinese_(Cantonese) [M]

If your input text begins with a left angle bracket (`<`) character, it will be interpreted as [SSML](#ssml).

## SSML

A subset of [SSML](https://www.w3.org/TR/speech-synthesis11/) is supported:

* `<speak>` - wrap around SSML text
    * `lang` - set language for document
* `<s>` - sentence (disables automatic sentence breaking)
    * `lang` - set language for sentence
* `<w>` / `<token>` - word (disables automatic tokenization)
* `<voice name="...">` - set voice of inner text
    * `voice` - name or language of voice
        * Name format is `tts:voice` (e.g., "glow-speak:en-us_mary_ann") or `tts:voice#speaker_id` (e.g., "coqui-tts:en_vctk#p228")
        * If one of the supported languages, a preferred voice is used (override with `--preferred-voice <lang> <voice>`)
* `<say-as interpret-as="">` - force interpretation of inner text
    * `interpret-as` one of "spell-out", "date", "number", "time", or "currency"
    * `format` - way to format text depending on `interpret-as`
        * number - one of "cardinal", "ordinal", "digits", "year"
        * date - string with "d" (cardinal day), "o" (ordinal day), "m" (month), or "y" (year)
* `<break time="">` - Pause for given amount of time
    * time - seconds ("123s") or milliseconds ("123ms")
* `<sub alias="">` - substitute `alias` for inner text

eg,

```xml
<speak>
  <s lang="zh">欢迎使用离线语音合成</s>
  <s lang="en-us">Welcome to Offline Speech Synthesis.</s>
</speak>
```

## Credit

* [Coqui-TTS](http://coqui.ai/)
* [ESpeaker](http://espeak.sourceforge.net)
* Main Inspired by [OpenTTS](https://github.com/synesthesiam/opentts).
  * Great Thanks. Without [OpenTTS](https://github.com/synesthesiam/opentts) there would be no Offline TTS.

## TODO

* [X] Upgrade Coqui-TTS from 0.3.1 to latest version 0.7.0dev
  * [X] fix: Check if optional dependencies are installed before loading ZH/JA phonememizer
  * [X] Remove matplotlib (It is only useful during the train analysis phase).
  * [X] Optimal Coqui-TTS  Models Size
  * [ ] Optimal Coqui-TTS  Models on Embedded device
* [X] Espeak Chinese locale missing
* [X] Show used languages only
* [X] Can not use [SSML](#ssml) on HA
* [X] Can not modify options on HA for the `/data/options.json` cannot read via common user.
* [ ] Add preferred voice for language option
