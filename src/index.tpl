<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Config Button</title>
<link rel="stylesheet" href="pure.css">
</head>
<body>
<div class="pure-g">
    <div class="pure-u-1 pure-u-md-1-3">&nbsp;</div>
    <div class="pure-u-1 pure-u-md-1-3">
        <form class="pure-form pure-form-stacked">
            <fieldset>
                <legend>Config IFTTT Button</legend>
                <p>
                <label for="dssid">SSID</label>
                <input type="text" id="dssid" name="dssid">
                </p>
                <p>
                <label for="password">Password</label>
                <input type="text" id="password" maxlength="100" name="password" value="">
                </p>
                <p>
                <label for="key">The key for IFTTT</label>
                <input type="text" id="key" name="key" value="">
                </p>
                <p> <button type="submit">Submit</button> </p>
            </fieldset>
        </form>
    </div>
    <div class="pure-u-1 pure-u-md-1-3">&nbsp;</div>
</div>
</body>
</html>
