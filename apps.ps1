Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$ErrorActionPreference = 'SilentlyContinue'
$wshell = New-Object -ComObject Wscript.Shell
$Button = [System.Windows.MessageBoxButton]::YesNoCancel
$ErrorIco = [System.Windows.MessageBoxImage]::Error
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

# GUI Specs
Write-Host "Checking winget..."

# Check if winget is installed
if (Test-Path ~\AppData\Local\Microsoft\WindowsApps\winget.exe){
    'Winget Already Installed'
}  
else{
    # Installing winget from the Microsoft Store
	Write-Host "Winget not found, installing it now."
    $ResultText.text = "`r`n" +"`r`n" + "Installing Winget... Please Wait"
	Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
	$nid = (Get-Process AppInstaller).Id
	Wait-Process -Id $nid
	Write-Host Winget Installed
    $ResultText.text = "`r`n" +"`r`n" + "Winget Installed - Ready for Next Task"
}

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(1050,1000)
$Form.text                       = "Windows Toolbox By Chris Titus"
$Form.StartPosition              = "CenterScreen"
$Form.TopMost                    = $false
$Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#e9e9e9")
$Form.AutoScaleDimensions     = '192, 192'
$Form.AutoScaleMode           = "Dpi"
$Form.AutoSize                = $True
$Form.AutoScroll              = $True
$Form.ClientSize              = '1050, 1000'
$Form.FormBorderStyle         = 'FixedSingle'

# GUI Icon
$iconBase64                      = 'AAABAAMAMDAAAAEAIACoJQAANgAAACAgAAABACAAqBAAAN4lAAAQEAAAAQAgAGgEAACGNgAAKAAAADAAAABgAAAAAQAgAAAAAAAAJAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEZGRgKxsbEBR0dHAq+vrwEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8C////Dt3d3Sm/v785wMDAOsDAwDrAwMA6wMDAOsDAwDrBwcE7wMDAPa6urjzm5uYV////AQAAAAAAAAAAAAAAAAAAAAD///8C3NzcIFNTU3O+vr5NVFRUdLy8vCj///8DAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////Af///wv///8R////BQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wL///8Xv7+/WYWFhaSPj4+vjo6OrY6Ojq2Ojo6tjo6OrY+Pj62Ojo6wh4eHqGxsbJfMzMwu////AwAAAAAAAAAAAAAAAP///wH///8O8PDwRnZ2dqnU1NRvdHR0ntLS0jn///8EAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////BqmpqUF7e3tu////GP///wEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////Af///w67u7tXiIiIua2trcecnJzEnJycwJubm7+bm5u/m5ubv52dncCKiorItra2m/X19Vf39/cg////AwAAAAAAAAAAAAAAAP///wPU1NQuhISEnn9/f7jX19dodnZ2ltPT0zX///8DAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////B6mpqVZ7e3uc////Mf///wgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wv///8J////CNjY2Dd8fHyonJycy5ycnM+mpqbSkJCQ2I6OjteOjo7Xjo6O2IuLi9KFhYXFgICAs2hoaKGvr68+////BQAAAAAAAAAAAAAAAP///wPc3Nw1hISEsISEhL/X19drd3d3l9PT0zX///8DAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////B7W1tVGFhYW2jIyMhvX19R3///8BAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJSUlGW8vLxZ7e3tQNHR0WtfX1/UlJSUz6GhocyJiYnci4uLzYaGhryGhoa7fX19wYGBganU1NRZxsbGRbS0tEXa2toe////AwAAAAAAAAAAAAAAAP///wXi4uI2jIyMrImJicbKysqUf39/ptXV1Tb///8DAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////B7W1tVCHh4fDf39/pfz8/CT///8CAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFpaWsdra2vQeXl5wYqKisBvb2/dmpqa0ZycnM5qamrcxcXFjfX19Vbj4+Ni6enpX+bm5kX///8a////C////wj///8E////AQAAAAAAAAAA////Au7u7hnAwMBokpKSuI+Pj9OEhITSeHh4u9vb2zj///8DAAAAAAAAAAAAAAAAAAAAAAAAAAD///8B////Cri4uFWJiYnBiIiInf///yH///8BAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAKqqqmOYmJiHhYWFpnt7e8BwcHDYampq34SEhNppaWnhkJCQs7GxsZF1dXWzhISEqp+fn4i3t7dm1tbWR/X19S7///8d////Ev///wj///8C////A9ra2jN0dHS0k5OTyZKSktSVlZXQf39/utnZ2Tj///8DAAAAAAAAAAAAAAAAAAAAAAAAAAD///8E29vbKqqqqoaOjo7HiIiInv///yP///8DAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wv///8V/f39JPX19UKSkpKbDw8P+BQUFPhoaGjVd3d3yGxsbNJoaGjdbGxs4m5ubuBwcHDZdnZ2y4CAgLWRkZGalZWVgb+/v0X///8P////B+fn5zKJiYmvl5eXy5GRkdOVlZXOfn5+utnZ2Tj///8EAAAAAAAAAAAAAAAAAAAAAAAAAAD///8HrKysU3Nzc8uUlJTOkZGRreXl5Un5+fkQ////AQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8B////Av///xGKiop+CwsL+goKCvyWlpaY7u7uT7y8vF+goKB/i4uLnnt7e7lxcXHNbW1t2mxsbOFubm7iZGRk4JKSkqrHx8dh5OTkQPDw8FGNjY20l5eXypGRkdOVlZXNgoKCvuLi4kj///8Q////Bv///wP///8BAAAAAAAAAAD///8GvLy8T4KCgsuWlpbQkJCQyHl5eaPl5eUp////AgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////Af///w6IiIh8CwsL+goKCvyFhYWC////FP///wr///8S////H/Hx8TLR0dFLsbGxapaWloqCgoKoc3NzwGdnZ85iYmLOaWlpwn9/f7uDg4PPnZ2dzZOTk9WXl5fPhYWF0JSUlKOxsbFr0dHRR/Ly8i3///8b////D////wj///8Ju7u7T4GBgcqWlpbPlpaWy4mJiafv7+8s////AwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///w6IiIh8CwsL+goKCvyDg4OA////EP///wH///8B////Af///wP///8G////DP///xb+/v4l6OjoOsXFxVWlpaV0ioqKlHNzc7F5eXnHampq2m5ubuSJiYnZgoKC3319feKIiIjYiIiIyYuLi7OVlZWVqampc8bGxlPv7+89zc3NbIODg86WlpbPlpaWypCQkKv09PQ6////BgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///w6IiIh8CwsL+goKCvyDg4OA////EAAAAAAAAAAAAAAAAAAAAAAAAAAA////Af///wH///8C////BP///wj///8P////Gvr6+izn5+dbRUVF0wYGBv8yMjLth4eHyXl5ec54eHjae3t74IGBgeKEhIThhISE3IWFhdCDg4PCi4uLx4uLi9uWlpbQmZmZy3h4eMmMjIx9////FP///wEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///w6IiIh7CwsL+goKCvyFhYWD////EQAAAAAAAAAAAAAAAAAAAAD///8D////CP///wj///8F////AQAAAAAAAAAA////Af///wT///8sQUFBxQAAAP8xMTHf6OjoZtLS0k+wsLBrl5eXi4WFhal5eXnBdHR003Z2dt13d3fid3d35IqKiuGZmZnTnZ2dzXd3d9aPj4+f////NP///xX///8L////Bv///wP///8B////AQAAAAAAAAAAAAAAAP///wySkpJzDg4O+AcHB/55eXmV////Gf///wEAAAAAAAAAAP///wXj4+MopqamW56enmK4uLg7////CQAAAAAAAAAAAAAAAP///wL///8pQEBAxAEBAf8sLCzZ5ubmPv///wr///8M////Fv39/Sbl5eU7xMTEV6ampnaPj4+Wf39/s319fcxhYWHidnZ23Xx8fNuEhITPkJCQp5ubm4WxsbFmzs7OSO7u7jD///8e////EgAAAAAAAAAAAAAAAP///wm1tbVcGRkZ7QICAv9OTk7D////Ov///wj///8C////BP///x6QkJCEGRkZ7RQUFPNycnKF////Ef///wH///8B////Af///wP///8qQEBAxAEBAf8sLCzZ5eXlPP///wX///8C////Av///wP///8E////Cf///xD///8c/Pz8MczMzHElJSXnBwcH/k5OTt+RkZHBgoKCyoCAgNOAgIDSgoKCx4eHh7SLi4ucjY2NdwAAAAAAAAAAAAAAAP///wTz8/M4PT09ygEBAf8UFBTzj4+PlP///zr///8f////Lru7u3MwMDDeAQEB/xwcHOu0tLRh////Df///xD///8b////Hf///x////9BR0dHygAAAP8wMDDd7OzsUv///yH///8e////HP///xP///8J////FP///x3///8f////JN3d3V8mJibkAAAA/2NjY8b///9p4+PjasbGxoevr6+ilZWVs4WFhcB6enrOeHh4tgAAAAAAAAAAAAAAAP///wH///8Xk5OTgBQUFPMBAQH/FRUV809PT8NwcHCjXFxctyIiIugDAwP/CQkJ/GZmZqj///8q////EIyMjGBRUVGrVFRUrVRUVK5hYWG6LCws6wEBAf8fHx/yYGBgwFVVVa9UVFSuUFBQrXt7e3T///8tc3NzfVFRUa1UVFSuVlZWr15eXsMZGRn0AgIC/zU1NeViYmK6W1tbtGFhYbhnZ2e7ubm5eerq6kW8vLxUpqamVwAAAAAAAAAAAAAAAAAAAAD///8F/Pz8L3Nzc50VFRXyAgIC/wEBAf8EBAT/AgIC/wEBAf8NDQ35VVVVuOLi4kX///8L////FWFhYZgDAwP/AgIC/wICAv8BAQH/AgIC/wICAv8CAgL/AQEB/wICAv8CAgL/AQEB/0hISLX///9IPDw8wQAAAP8CAgL/AgIC/wEBAf8CAgL/AgIC/wEBAf8BAQH/AQEB/wEBAf8FBQX+dXV1hv///xT///8I////CAAAAAAAAAAAAAAAAAAAAAAAAAAA////CPn5+S6ampp6RkZGwCQkJOIaGhrsHx8f5js7O8uDg4OM6urqPP///w3///8C////EHV1dXwqKirYKysr2SsrK9krKyvZKysr2SsrK9krKyvZKysr2SsrK9krKyvZKCgo2mBgYJX///85VlZWoCgoKNorKyvZKysr2SsrK9krKyvZKysr2SsrK9krKyvZKysr2SsrK9ksLCzWhYWFbf///w3///8BAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wT///8T9/f3K83NzUK0tLRMw8PDRu/v7zH///8X////Bv///wEAAAAA////Benp6R7f39814eHhOOHh4Tjh4eE44eHhOOHh4Tjh4eE44eHhOOHh4Tjh4eE439/fNuXl5ST///8Q5OTkJ9/f3zfh4eE44eHhOOHh4Tjh4eE44eHhOOHh4Tjh4eE44eHhOOHh4Tjf39806+vrG////wQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///////wAA////////AAD///////8AAP///////wAA////////AAD///////8AAP///////wAA////////AAD///////8AAP///////wAA////////AAD///////8AAP///////wAA////////AAD///////8AAPwA/1///wAA+AH+X/v/AADwAP5f+f8AAPAH/h/5/wAAAH/+H/n/AACAB/wf8f8AAPAAPB/x/wAA+OAcH/D/AAD4/gAP8P8AAPj/8ADw/wAA+P/+AAD/AAD4//44AH8AAPj//j/AHwAA+Ph+P/gBAAD4eP4/+MAAAPgA4AOADwAA/AHAAQAHAAD/A+ABAA8AAP///////wAA////////AAD///////8AAP///////wAA////////AAD///////8AAP///////wAA////////AAD///////8AAP///////wAA////////AAD///////8AAP///////wAA////////AAD///////8AACgAAAAgAAAAQAAAAAEAIAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD29vYJubm5JK6uri2vr68tr6+vLbCwsC2srKwvo6OjJv///wQAAAAAAAAAAAAAAACtra0Td3d3RHt7e0Senp4YAAAAAAAAAAAAAAAAAAAAAP///wHq6uoM7u7uBwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/v7+DKqqql+YmJiql5eXrZaWlqyWlpaslZWVr5WVlaWfn59j////CwAAAAAAAAAA////BbCwsE+RkZGVlJSUhbKysi8AAAAAAAAAAAAAAAAAAAAA////BoyMjFioqKg5////AQAAAAAAAAAAAAAAAAAAAAAAAAAA////Cf///waqqqpIj4+PvKOjo8+WlpbSkJCQ0pCQkNKOjo7Lj4+Pr5mZmWzp6ekPAAAAAAAAAAD///8NjIyMjJSUlKSZmZmAs7OzLAAAAAAAAAAAAAAAAAAAAAD///8GlZWVcJeXl4Hi4uITAAAAAAAAAAAAAAAAAAAAAAAAAAB9fX2DpKSkbY6Ojp2FhYXUlpaW0o+Pj8OcnJydlZWVoKCgoHbBwcE7qKioLu7u7gcAAAAAAAAAAPn5+Rebm5uRlZWVv5CQkKO7u7stAAAAAAAAAAAAAAAAAAAAAP///waZmZlzh4eHq9bW1h8AAAAAAAAAAAAAAAAAAAAAAAAAAIGBgYyBgYGqfHx8xnV1ddt4eHjdiIiIuKysrIiUlJSUr6+vasPDwz7n5+cj/v7+Ev///wX///8BoqKiTI6Ojr6SkpLUhISEvcPDwy4AAAAAAAAAAAAAAAAAAAAA3d3dG5qampCNjY2n3NzcHgAAAAAAAAAAAAAAAAAAAAAAAAAA////DPDw8BvGxsZRKysr3iwsLOqKioqre3t7tHFxcc5xcXHWdHR0z319fbuBgYGfs7OzUf///xasrKxckZGRyJSUlNGJiYm6xMTEMAAAAAAAAAAAAAAAAAAAAACqqqo/hoaGxpOTk7uwsLBQ////BQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM7OzioiIiLZIiIi3djY2Dzk5OQivr6+PqSkpF+Pj4+EgICAqHR0dMN3d3e8f39/n4qKiqqSkpLOlpaW0oyMjMmkpKR9v7+/P9/f3yL9/f0P////BbGxsT+Li4vHk5OTzpKSkoP///8LAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAz8/PKyIiItkgICDcysrKLAAAAAAAAAAA////Av///wn39/cW09PTK66urkmUlJRsiYmJkWxsbMtUVFToe3t73X5+ft2GhobQi4uLuZSUlJekpKRxqqqqfo2Njc2VlZXNlpaWluDg4BoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADPz88qIiIi2SEhIdzLy8suAAAAAAAAAAD///8B////Bf///wb///8BAAAAAP///wT///8UVlZWngsLC/5/f3+foaGheYuLi5yCgoK7fn5+0Xx8fNt6enrfjIyM3JmZmc98fHzGvr6+Tf///xD///8G////AQAAAAAAAAAAAAAAAODg4CQoKCjQGxsb6ba2tkMAAAAAAAAAAOrq6hhqampzXV1df8LCwh8AAAAAAAAAAP///whPT0+WDAwM/XZ2dmr///8H/f39EN7e3iO6uro+o6OjYJSUlIV3d3fATk5O6HNzc9mLi4u4kJCQlpycnHWurq5Surq6NQAAAAAAAAAA////E0hISKkKCgr+ZGRkmvf39yr///8ihISEehQUFPMvLy/M3d3dJ////xD///8Z////IltbW6ENDQ39hoaGeP///xv///8Y////Df///w7///8c////JoGBgYoKCgr9cXFxury8vImjo6Ook5OTuoaGhr19fX2uAAAAAAAAAAD///8DmpqaVB8fH+QODg74NDQ0zTk5OcYTExPzFRUV8H5+fnD///8WVVVVhi4uLsY0NDTGJSUl5wYGBv4uLi7dMjIyxS8vL8R8fHxsc3Nzci8vL8QyMjLFLCws3gUFBf4pKSnkOjo6yTs7O9F1dXWY1dXVP6qqqkQAAAAAAAAAAAAAAAD///8Ojo6OYTY2NsMYGBjpFhYW7C4uLsx9fX1y/Pz8FP///xBISEicHBwc5R0dHeIdHR3gHx8f3x0dHeEdHR3iHh4e4nJycn1oaGiFHR0d4x0dHeIdHR3hHx8f3x0dHeAdHR3iHBwc5E5OTpD///8LAAAAAAAAAAAAAAAAAAAAAAAAAAD///8G39/fHqKiojacnJw41dXVIv///wgAAAAA////A8HBwR62trYtuLi4Lbi4uC24uLgtuLi4Lbi4uC22trYsz8/PGMzMzBq2trYtuLi4Lbi4uC24uLgtuLi4Lbi4uC22trYtw8PDHP///wIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA//////////////////////////////////////////////////////A/P//gPj+/QP4/vwD+Pz/gDj8/54A/H+f8Ax/n/iAf5/5+B+OefwDwMAwD+HAIA/////////////////////////////////////////////////////8oAAAAEAAAACAAAAABACAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC+vr4Gp6enHaWlpSCioqIhp6enDgAAAACgoKAJhoaGI5SUlAkAAAAAy8vLAa+vrwcAAAAAAAAAAAAAAADNzc0NoKCgXJqamrKUlJSylJSUn6SkpDcAAAAAnJycPZaWloWlpaUdAAAAALe3twqYmJhPubm5DAAAAAAAAAAAjIyMeICAgLqGhobNlZWVpZycnHCtra0q////BJqammyRkZGwoqKiIAAAAAC5ubkTlJSUg62trR0AAAAAAAAAANbW1hdJSUmRUFBQrJGRkW+Dg4OOgYGBlo+Pj2yRkZGlj4+Px5+fn0++vr4VqqqqMJGRkbOioqI+AAAAAAAAAAAAAAAANjY2gTU1NYQAAAAA19fXDq2trSWcnJw2a2triVhYWM+Ojo6ei4uLnYyMjKGOjo7OlJSUdtTU1A7v7+8EAAAAAEFBQW8yMjKtpaWlJ0NDQ31TU1Nc1NTUD0xMTGwyMjKyra2tLqKiojiUlJRmUlJSynR0dLuWlpaPlJSUcQAAAAB+fn4jMjIyrC0tLcQwMDCzfHx8Pj4+Po8pKSnIIiIi0zIyMq9hYWFzMTExryEhIdMuLi7NTk5Oo6ampjgAAAAAAAAAAJCQkBJcXFwqiIiIFN7e3gNra2sfY2NjJmdnZyVkZGQliIiIGWNjYyVnZ2clYmJiJmhoaB28vLwCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP//AAD//wAA//8AAP//AAD//wAAx38AAI93AACSdwAAngcAAN9xAADEIQAA//8AAP//AAD//wAA//8AAP//AAA='
$iconBytes                       = [Convert]::FromBase64String($iconBase64)
$stream                          = New-Object IO.MemoryStream($iconBytes, 0, $iconBytes.Length)
$stream.Write($iconBytes, 0, $iconBytes.Length)
$Form.Icon                    = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap -Argument $stream).GetHIcon())

$Form.Width                   = $objImage.Width
$Form.Height                  = $objImage.Height

$Panel1                          = New-Object system.Windows.Forms.Panel
$Panel1.height                   = 939
$Panel1.width                    = 219
$Panel1.location                 = New-Object System.Drawing.Point(6,54)

$brave                           = New-Object system.Windows.Forms.Button
$brave.text                      = "Brave Browser"
$brave.width                     = 212
$brave.height                    = 30
$brave.location                  = New-Object System.Drawing.Point(4,426)
$brave.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$7zip                            = New-Object system.Windows.Forms.Button
$7zip.text                       = "7-Zip"
$7zip.width                      = 211
$7zip.height                     = 30
$7zip.location                   = New-Object System.Drawing.Point(4,102)
$7zip.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$sharex                          = New-Object system.Windows.Forms.Button
$sharex.text                     = "ShareX (Screenshots)"
$sharex.width                    = 212
$sharex.height                   = 30
$sharex.location                 = New-Object System.Drawing.Point(3,561)
$sharex.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$adobereader                     = New-Object system.Windows.Forms.Button
$adobereader.text                = "Adobe Reader DC"
$adobereader.width               = 212
$adobereader.height              = 30
$adobereader.location            = New-Object System.Drawing.Point(3,865)
$adobereader.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$notepad                         = New-Object system.Windows.Forms.Button
$notepad.text                    = "Notepad++"
$notepad.width                   = 212
$notepad.height                  = 30
$notepad.location                = New-Object System.Drawing.Point(3,831)
$notepad.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$mpc                             = New-Object system.Windows.Forms.Button
$mpc.text                        = "Media Player Classic"
$mpc.width                       = 211
$mpc.height                      = 30
$mpc.location                    = New-Object System.Drawing.Point(3,697)
$mpc.Font                        = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$vlc                             = New-Object system.Windows.Forms.Button
$vlc.text                        = "VLC"
$vlc.width                       = 212
$vlc.height                      = 30
$vlc.location                    = New-Object System.Drawing.Point(3,663)
$vlc.Font                        = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$powertoys                       = New-Object system.Windows.Forms.Button
$powertoys.text                  = "PowerToys"
$powertoys.width                 = 211
$powertoys.height                = 30
$powertoys.location              = New-Object System.Drawing.Point(4,67)
$powertoys.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$winterminal                     = New-Object system.Windows.Forms.Button
$winterminal.text                = "Windows Terminal"
$winterminal.width               = 211
$winterminal.height              = 30
$winterminal.location            = New-Object System.Drawing.Point(3,32)
$winterminal.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$vscode                          = New-Object system.Windows.Forms.Button
$vscode.text                     = "VS Code"
$vscode.width                    = 211
$vscode.height                   = 30
$vscode.location                 = New-Object System.Drawing.Point(4,797)
$vscode.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "Utilities"
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(89,11)
$Label2.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$Panel2                          = New-Object system.Windows.Forms.Panel
$Panel2.height                   = 938
$Panel2.width                    = 211
$Panel2.location                 = New-Object System.Drawing.Point(240,54)

$Label3                          = New-Object system.Windows.Forms.Label
$Label3.text                     = "System Tweaks"
$Label3.AutoSize                 = $true
$Label3.width                    = 230
$Label3.height                   = 25
$Label3.location                 = New-Object System.Drawing.Point(349,11)
$Label3.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',24)

$essentialtweaks                 = New-Object system.Windows.Forms.Button
$essentialtweaks.text            = "Essential Tweaks"
$essentialtweaks.width           = 205
$essentialtweaks.height          = 75
$essentialtweaks.location        = New-Object System.Drawing.Point(0,17)
$essentialtweaks.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$backgroundapps                  = New-Object system.Windows.Forms.Button
$backgroundapps.text             = "Disable Background Apps"
$backgroundapps.width            = 205
$backgroundapps.height           = 30
$backgroundapps.location         = New-Object System.Drawing.Point(3,453)
$backgroundapps.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$cortana                         = New-Object system.Windows.Forms.Button
$cortana.text                    = "Disable Cortana (Search)"
$cortana.width                   = 205
$cortana.height                  = 30
$cortana.location                = New-Object System.Drawing.Point(2,588)
$cortana.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$actioncenter                    = New-Object system.Windows.Forms.Button
$actioncenter.text               = "Disable Action Center"
$actioncenter.width              = 205
$actioncenter.height             = 30
$actioncenter.location           = New-Object System.Drawing.Point(3,176)
$actioncenter.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$darkmode                        = New-Object system.Windows.Forms.Button
$darkmode.text                   = "Dark Mode"
$darkmode.width                  = 205
$darkmode.height                 = 30
$darkmode.location               = New-Object System.Drawing.Point(4,315)
$darkmode.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$performancefx                   = New-Object system.Windows.Forms.Button
$performancefx.text              = "Performance Visual FX"
$performancefx.width             = 205
$performancefx.height            = 30
$performancefx.location          = New-Object System.Drawing.Point(3,419)
$performancefx.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$onedrive                        = New-Object system.Windows.Forms.Button
$onedrive.text                   = "Delete & Disable  OneDrive"
$onedrive.width                  = 205
$onedrive.height                 = 30
$onedrive.location               = New-Object System.Drawing.Point(3,521)
$onedrive.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Label15                         = New-Object system.Windows.Forms.Label
$Label15.text                    = "Windows Update"
$Label15.AutoSize                = $true
$Label15.width                   = 25
$Label15.height                  = 10
$Label15.location                = New-Object System.Drawing.Point(732,11)
$Label15.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',24)

$Panel4                          = New-Object system.Windows.Forms.Panel
$Panel4.height                   = 328
$Panel4.width                    = 340
$Panel4.location                 = New-Object System.Drawing.Point(699,54)

$defaultwindowsupdate            = New-Object system.Windows.Forms.Button
$defaultwindowsupdate.text       = "Default Settings"
$defaultwindowsupdate.width      = 300
$defaultwindowsupdate.height     = 30
$defaultwindowsupdate.location   = New-Object System.Drawing.Point(24,26)
$defaultwindowsupdate.Font       = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$securitywindowsupdate           = New-Object system.Windows.Forms.Button
$securitywindowsupdate.text      = "Security Updates Only"
$securitywindowsupdate.width     = 300
$securitywindowsupdate.height    = 30
$securitywindowsupdate.location  = New-Object System.Drawing.Point(24,142)
$securitywindowsupdate.Font      = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$Label16                         = New-Object system.Windows.Forms.Label
$Label16.text                    = "I recommend doing security updates only."
$Label16.AutoSize                = $true
$Label16.width                   = 25
$Label16.height                  = 10
$Label16.location                = New-Object System.Drawing.Point(62,65)
$Label16.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label17                         = New-Object system.Windows.Forms.Label
$Label17.text                    = "- Delays Features updates up to 3 years"
$Label17.AutoSize                = $true
$Label17.width                   = 25
$Label17.height                  = 10
$Label17.location                = New-Object System.Drawing.Point(63,84)
$Label17.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label18                         = New-Object system.Windows.Forms.Label
$Label18.text                    = "- Delays Security updates 4 days"
$Label18.AutoSize                = $true
$Label18.width                   = 25
$Label18.height                  = 10
$Label18.location                = New-Object System.Drawing.Point(63,105)
$Label18.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label19                         = New-Object system.Windows.Forms.Label
$Label19.text                    = "- Sets Maximum Active Time"
$Label19.AutoSize                = $true
$Label19.width                   = 25
$Label19.height                  = 10
$Label19.location                = New-Object System.Drawing.Point(63,126)
$Label19.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$PictureBox1                     = New-Object system.Windows.Forms.PictureBox
$PictureBox1.width               = 343
$PictureBox1.height              = 136
$PictureBox1.location            = New-Object System.Drawing.Point(580,850)
$PictureBox1.imageLocation       = "https://github.com/ChrisTitusTech/win10script/blob/master/titus-toolbox.png?raw=true"
$PictureBox1.SizeMode            = [System.Windows.Forms.PictureBoxSizeMode]::zoom
$lightmode                       = New-Object system.Windows.Forms.Button
$lightmode.text                  = "Light Mode"
$lightmode.width                 = 205
$lightmode.height                = 30
$lightmode.location              = New-Object System.Drawing.Point(3,350)
$lightmode.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Install"
$Label1.AutoSize                 = $true
$Label1.width                    = 230
$Label1.height                   = 25
$Label1.location                 = New-Object System.Drawing.Point(76,11)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',24)

$Panel3                          = New-Object system.Windows.Forms.Panel
$Panel3.height                   = 381
$Panel3.width                    = 220
$Panel3.location                 = New-Object System.Drawing.Point(464,54)

$essentialundo                   = New-Object system.Windows.Forms.Button
$essentialundo.text              = "Undo Essential Tweaks"
$essentialundo.width             = 205
$essentialundo.height            = 70
$essentialundo.location          = New-Object System.Drawing.Point(3,102)
$essentialundo.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$EActionCenter                   = New-Object system.Windows.Forms.Button
$EActionCenter.text              = "Enable Action Center"
$EActionCenter.width             = 205
$EActionCenter.height            = 30
$EActionCenter.location          = New-Object System.Drawing.Point(3,210)
$EActionCenter.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$ECortana                        = New-Object system.Windows.Forms.Button
$ECortana.text                   = "Enable Cortana (Search)"
$ECortana.width                  = 205
$ECortana.height                 = 30
$ECortana.location               = New-Object System.Drawing.Point(3,622)
$ECortana.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$RBackgroundApps                 = New-Object system.Windows.Forms.Button
$RBackgroundApps.text            = "Allow Background Apps"
$RBackgroundApps.width           = 205
$RBackgroundApps.height          = 30
$RBackgroundApps.location        = New-Object System.Drawing.Point(3,487)
$RBackgroundApps.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$HTrayIcons                      = New-Object system.Windows.Forms.Button
$HTrayIcons.text                 = "Hide Tray Icons"
$HTrayIcons.width                = 205
$HTrayIcons.height               = 30
$HTrayIcons.location             = New-Object System.Drawing.Point(3,278)
$HTrayIcons.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$EClipboardHistory               = New-Object system.Windows.Forms.Button
$EClipboardHistory.text          = "Enable Clipboard History"
$EClipboardHistory.width         = 205
$EClipboardHistory.height        = 30
$EClipboardHistory.location      = New-Object System.Drawing.Point(3,688)
$EClipboardHistory.Font          = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$ELocation                       = New-Object system.Windows.Forms.Button
$ELocation.text                  = "Enable Location Tracking"
$ELocation.width                 = 205
$ELocation.height                = 30
$ELocation.location              = New-Object System.Drawing.Point(2,655)
$ELocation.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$InstallOneDrive                 = New-Object system.Windows.Forms.Button
$InstallOneDrive.text            = "Install & Enable OneDrive"
$InstallOneDrive.width           = 205
$InstallOneDrive.height          = 30
$InstallOneDrive.location        = New-Object System.Drawing.Point(2,554)
$InstallOneDrive.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$everythingsearch                = New-Object system.Windows.Forms.Button
$everythingsearch.text           = "Everything Search"
$everythingsearch.width          = 211
$everythingsearch.height         = 30
$everythingsearch.location       = New-Object System.Drawing.Point(3,368)
$everythingsearch.Font           = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$sumatrapdf                      = New-Object system.Windows.Forms.Button
$sumatrapdf.text                 = "Sumatra PDF"
$sumatrapdf.width                = 212
$sumatrapdf.height               = 30
$sumatrapdf.location             = New-Object System.Drawing.Point(4,900)
$sumatrapdf.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$vscodium                        = New-Object system.Windows.Forms.Button
$vscodium.text                   = "VS Codium"
$vscodium.width                  = 211
$vscodium.height                 = 30
$vscodium.location               = New-Object System.Drawing.Point(4,763)
$vscodium.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$imageglass                      = New-Object system.Windows.Forms.Button
$imageglass.text                 = "ImageGlass (Image Viewer)"
$imageglass.width                = 212
$imageglass.height               = 30
$imageglass.location             = New-Object System.Drawing.Point(4,595)
$imageglass.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$gimp                            = New-Object system.Windows.Forms.Button
$gimp.text                       = "GIMP (Image Editor)"
$gimp.width                      = 212
$gimp.height                     = 30
$gimp.location                   = New-Object System.Drawing.Point(4,629)
$gimp.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$yourphonefix                    = New-Object system.Windows.Forms.Button
$yourphonefix.text               = "Your Phone App Fix"
$yourphonefix.width              = 211
$yourphonefix.height             = 30
$yourphonefix.location           = New-Object System.Drawing.Point(5,332)
$yourphonefix.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$removebloat                     = New-Object system.Windows.Forms.Button
$removebloat.text                = "Remove MS Store Apps"
$removebloat.width               = 204
$removebloat.height              = 34
$removebloat.location            = New-Object System.Drawing.Point(3,898)
$removebloat.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$reinstallbloat                  = New-Object system.Windows.Forms.Button
$reinstallbloat.text             = "Reinstall MS Store Apps"
$reinstallbloat.width            = 205
$reinstallbloat.height           = 30
$reinstallbloat.location         = New-Object System.Drawing.Point(3,813)
$reinstallbloat.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$WarningLabel                    = New-Object system.Windows.Forms.Label
$WarningLabel.text               = "Warning! This will break Microsoft Store"
$WarningLabel.AutoSize           = $true
$WarningLabel.width              = 25
$WarningLabel.height             = 10
$WarningLabel.location           = New-Object System.Drawing.Point(12,856)
$WarningLabel.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',8)

$Label5                          = New-Object system.Windows.Forms.Label
$Label5.text                     = "Games, Apps, Sysprep, etc."
$Label5.AutoSize                 = $true
$Label5.width                    = 25
$Label5.height                   = 10
$Label5.location                 = New-Object System.Drawing.Point(44,877)
$Label5.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',8)

$Label7                          = New-Object system.Windows.Forms.Label
$Label7.text                     = "Document Tools"
$Label7.AutoSize                 = $true
$Label7.width                    = 25
$Label7.height                   = 10
$Label7.location                 = New-Object System.Drawing.Point(60,740)
$Label7.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$Label8                          = New-Object system.Windows.Forms.Label
$Label8.text                     = "Video and Image Tools"
$Label8.AutoSize                 = $true
$Label8.width                    = 25
$Label8.height                   = 10
$Label8.location                 = New-Object System.Drawing.Point(41,537)
$Label8.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$Label9                          = New-Object system.Windows.Forms.Label
$Label9.text                     = "Web Browsers"
$Label9.AutoSize                 = $true
$Label9.width                    = 25
$Label9.height                   = 10
$Label9.location                 = New-Object System.Drawing.Point(67,406)
$Label9.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$advancedipscanner               = New-Object system.Windows.Forms.Button
$advancedipscanner.text          = "Advanced IP Scanner"
$advancedipscanner.width         = 211
$advancedipscanner.height        = 30
$advancedipscanner.location      = New-Object System.Drawing.Point(3,335)
$advancedipscanner.Font          = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$putty                           = New-Object system.Windows.Forms.Button
$putty.text                      = "PuTTY & WinSCP"
$putty.width                     = 211
$putty.height                    = 30
$putty.location                  = New-Object System.Drawing.Point(3,302)
$putty.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$etcher                          = New-Object system.Windows.Forms.Button
$etcher.text                     = "Etcher USB Creator"
$etcher.width                    = 211
$etcher.height                   = 30
$etcher.location                 = New-Object System.Drawing.Point(3,269)
$etcher.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$translucenttb                   = New-Object system.Windows.Forms.Button
$translucenttb.text              = "Translucent Taskbar"
$translucenttb.width             = 211
$translucenttb.height            = 30
$translucenttb.location          = New-Object System.Drawing.Point(3,236)
$translucenttb.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$githubdesktop                   = New-Object system.Windows.Forms.Button
$githubdesktop.text              = "Github Desktop"
$githubdesktop.width             = 211
$githubdesktop.height            = 30
$githubdesktop.location          = New-Object System.Drawing.Point(3,203)
$githubdesktop.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$discord                         = New-Object system.Windows.Forms.Button
$discord.text                    = "Discord"
$discord.width                   = 211
$discord.height                  = 30
$discord.location                = New-Object System.Drawing.Point(4,170)
$discord.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$autohotkey                      = New-Object system.Windows.Forms.Button
$autohotkey.text                 = "AutoHotkey"
$autohotkey.width                = 211
$autohotkey.height               = 30
$autohotkey.location             = New-Object System.Drawing.Point(4,136)
$autohotkey.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$appearancefx                    = New-Object system.Windows.Forms.Button
$appearancefx.text               = "Appearance Visual FX"
$appearancefx.width              = 205
$appearancefx.height             = 30
$appearancefx.location           = New-Object System.Drawing.Point(4,385)
$appearancefx.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$STrayIcons                      = New-Object system.Windows.Forms.Button
$STrayIcons.text                 = "Show Tray Icons"
$STrayIcons.width                = 205
$STrayIcons.height               = 30
$STrayIcons.location             = New-Object System.Drawing.Point(2,244)
$STrayIcons.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$windowsupdatefix                = New-Object system.Windows.Forms.Button
$windowsupdatefix.text           = "Windows Update Reset"
$windowsupdatefix.width          = 300
$windowsupdatefix.height         = 30
$windowsupdatefix.location       = New-Object System.Drawing.Point(25,216)
$windowsupdatefix.Font           = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$ResultText                      = New-Object system.Windows.Forms.TextBox
$ResultText.multiline            = $true
$ResultText.width                = 382
$ResultText.height               = 130
$ResultText.location             = New-Object System.Drawing.Point(576,491)
$ResultText.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label10                         = New-Object system.Windows.Forms.Label
$Label10.text                    = "Current Status:"
$Label10.AutoSize                = $true
$Label10.width                   = 25
$Label10.height                  = 10
$Label10.location                = New-Object System.Drawing.Point(658,448)
$Label10.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',24)

$EHibernation                    = New-Object system.Windows.Forms.Button
$EHibernation.text               = "Enable Hibernation"
$EHibernation.width              = 205
$EHibernation.height             = 30
$EHibernation.location           = New-Object System.Drawing.Point(3,721)
$EHibernation.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$dualboottime                    = New-Object system.Windows.Forms.Button
$dualboottime.text               = "Set Time to UTC (Dual Boot)"
$dualboottime.width              = 205
$dualboottime.height             = 30
$dualboottime.location           = New-Object System.Drawing.Point(3,754)
$dualboottime.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Label11                         = New-Object system.Windows.Forms.Label
$Label11.text                    = "Videos to Fix Windows"
$Label11.AutoSize                = $true
$Label11.width                   = 25
$Label11.height                  = 10
$Label11.location                = New-Object System.Drawing.Point(687,659)
$Label11.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$urlfixwinstartup                = New-Object system.Windows.Forms.Button
$urlfixwinstartup.text           = "Repair Windows Startup"
$urlfixwinstartup.width          = 232
$urlfixwinstartup.height         = 30
$urlfixwinstartup.location       = New-Object System.Drawing.Point(646,702)
$urlfixwinstartup.Font           = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$urlremovevirus                  = New-Object system.Windows.Forms.Button
$urlremovevirus.text             = "Clean Viruses"
$urlremovevirus.width            = 232
$urlremovevirus.height           = 30
$urlremovevirus.location         = New-Object System.Drawing.Point(646,745)
$urlremovevirus.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$urlcreateiso                    = New-Object system.Windows.Forms.Button
$urlcreateiso.text               = "Create Custom ISO"
$urlcreateiso.width              = 232
$urlcreateiso.height             = 30
$urlcreateiso.location           = New-Object System.Drawing.Point(646,790)
$urlcreateiso.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ncpa                            = New-Object system.Windows.Forms.Button
$ncpa.text                       = "Network Connections"
$ncpa.width                      = 211
$ncpa.height                     = 30
$ncpa.location                   = New-Object System.Drawing.Point(4,126)
$ncpa.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$oldcontrolpanel                 = New-Object system.Windows.Forms.Button
$oldcontrolpanel.text            = "Win7 Control Panel"
$oldcontrolpanel.width           = 211
$oldcontrolpanel.height          = 30
$oldcontrolpanel.location        = New-Object System.Drawing.Point(4,193)
$oldcontrolpanel.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$oldsoundpanel                   = New-Object system.Windows.Forms.Button
$oldsoundpanel.text              = "Win7 Sound Panel"
$oldsoundpanel.width             = 211
$oldsoundpanel.height            = 30
$oldsoundpanel.location          = New-Object System.Drawing.Point(5,262)
$oldsoundpanel.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$oldsystempanel                  = New-Object system.Windows.Forms.Button
$oldsystempanel.text             = "Win7 System Panel"
$oldsystempanel.width            = 211
$oldsystempanel.height           = 30
$oldsystempanel.location         = New-Object System.Drawing.Point(5,298)
$oldsystempanel.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$NFS                             = New-Object system.Windows.Forms.Button
$NFS.text                        = "Enable NFS"
$NFS.width                       = 211
$NFS.height                      = 30
$NFS.location                    = New-Object System.Drawing.Point(4,57)
$NFS.Font                        = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$laptopnumlock                   = New-Object system.Windows.Forms.Button
$laptopnumlock.text              = "Laptop Numlock Fix"
$laptopnumlock.width             = 211
$laptopnumlock.height            = 30
$laptopnumlock.location          = New-Object System.Drawing.Point(4,92)
$laptopnumlock.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$disableupdates                  = New-Object system.Windows.Forms.Button
$disableupdates.text             = "Disable Update Services"
$disableupdates.width            = 300
$disableupdates.height           = 30
$disableupdates.location         = New-Object System.Drawing.Point(23,292)
$disableupdates.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$enableupdates                   = New-Object system.Windows.Forms.Button
$enableupdates.text              = "Enable Update Services"
$enableupdates.width             = 300
$enableupdates.height            = 30
$enableupdates.location          = New-Object System.Drawing.Point(25,179)
$enableupdates.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$Label12                         = New-Object system.Windows.Forms.Label
$Label12.text                    = "NOT RECOMMENDED!!!"
$Label12.AutoSize                = $true
$Label12.width                   = 25
$Label12.height                  = 10
$Label12.location                = New-Object System.Drawing.Point(98,275)
$Label12.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$Virtualization                  = New-Object system.Windows.Forms.Button
$Virtualization.text             = "Enable HyperV + WSL"
$Virtualization.width            = 211
$Virtualization.height           = 30
$Virtualization.location         = New-Object System.Drawing.Point(4,23)
$Virtualization.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$oldpower                        = New-Object system.Windows.Forms.Button
$oldpower.text                   = "Win7 Power Panel"
$oldpower.width                  = 211
$oldpower.height                 = 30
$oldpower.location               = New-Object System.Drawing.Point(4,227)
$oldpower.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$restorepower                    = New-Object system.Windows.Forms.Button
$restorepower.text               = "Restore Power Options"
$restorepower.width              = 211
$restorepower.height             = 30
$restorepower.location           = New-Object System.Drawing.Point(4,159)
$restorepower.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Form.controls.AddRange(@($Panel1,$Panel2,$Label3,$Label15,$Panel4,$PictureBox1,$Label1,$Panel3,$ResultText,$Label10,$Label11,$urlfixwinstartup,$urlremovevirus,$urlcreateiso))
$Panel1.controls.AddRange(@($brave,$firefox,$7zip,$sharex,$adobereader,$notepad,$gchrome,$mpc,$vlc,$powertoys,$winterminal,$vscode,$Label2,$everythingsearch,$sumatrapdf,$vscodium,$imageglass,$gimp,$Label7,$Label8,$Label9,$advancedipscanner,$putty,$etcher,$translucenttb,$githubdesktop,$discord,$autohotkey))
$Panel2.controls.AddRange(@($essentialtweaks,$backgroundapps,$cortana,$actioncenter,$darkmode,$performancefx,$onedrive,$lightmode,$essentialundo,$EActionCenter,$ECortana,$RBackgroundApps,$HTrayIcons,$EClipboardHistory,$ELocation,$InstallOneDrive,$removebloat,$reinstallbloat,$WarningLabel,$Label5,$appearancefx,$STrayIcons,$EHibernation,$dualboottime))
$Panel4.controls.AddRange(@($defaultwindowsupdate,$securitywindowsupdate,$Label16,$Label17,$Label18,$Label19,$windowsupdatefix,$disableupdates,$enableupdates,$Label12))
$Panel3.controls.AddRange(@($yourphonefix,$ncpa,$oldcontrolpanel,$oldsoundpanel,$oldsystempanel,$NFS,$laptopnumlock,$Virtualization,$oldpower,$restorepower))

$brave.Add_Click({
    Write-Host "Installing Brave Browser"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Brave... Please Wait" 
    winget install -e BraveSoftware.BraveBrowser | Out-Host
    if($?) { Write-Host "Installed Brave Browser" }
    $ResultText.text = "`r`n" + "Finished Installing Brave" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$autohotkey.Add_Click({
    Write-Host "Installing AutoHotkey"
    $ResultText.text = "`r`n" +"`r`n" + "Installing AutoHotkey... Please Wait" 
    winget install -e Lexikos.AutoHotkey | Out-Host
    if($?) { Write-Host "Installed AutoHotkey" }
    $ResultText.text = "`r`n" + "Finished Installing Autohotkey" + "`r`n" + "`r`n" + "Ready for Next Task"
})
$imageglass.Add_Click({
    Write-Host "Installing Image Glass (Image Viewer)"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Image Glass... Please Wait" 
    winget install -e DuongDieuPhap.ImageGlass | Out-Host
    if($?) { Write-Host "Installed Image Glass (Image Viewer)" }
    $ResultText.text = "`r`n" + "Finished Installing Image Glass" + "`r`n" + "`r`n" + "Ready for Next Task"
})
$discord.Add_Click({
    Write-Host "Installing Discord"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Discord... Please Wait" 
    winget install -e Discord.Discord | Out-Host
    if($?) { Write-Host "Installed Discord" }
    $ResultText.text = "`r`n" + "Finished Installing Discord" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$adobereader.Add_Click({
    Write-Host "Installing Adobe Reader DC"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Adobe Reader DC... Please Wait" 
    winget install -e --id Adobe.Acrobat.Reader.64-bit | Out-Host
    if($?) { Write-Host "Installed Adobe Reader DC" }
    $ResultText.text = "`r`n" + "Finished Installing Adobe Reader DC" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$notepad.Add_Click({
    Write-Host "Installing Notepad++"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Notepad++... Please Wait" 
    winget install -e Notepad++.Notepad++ | Out-Host
    if($?) { Write-Host "Installed Notepad++" }
    $ResultText.text = "`r`n" + "Finished Installing NotePad++" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$vlc.Add_Click({
    Write-Host "Installing VLC Media Player"
    $ResultText.text = "`r`n" +"`r`n" + "Installing VLC Media Player... Please Wait" 
    winget install -e VideoLAN.VLC | Out-Host
    if($?) { Write-Host "Installed VLC Media Player" }
    $ResultText.text = "`r`n" + "Finished Installing VLC Media Player" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$mpc.Add_Click({
    Write-Host "Installing Media Player Classic"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Media Player Classic... Please Wait" 
    winget install -e clsid2.mpc-hc | Out-Host
    if($?) { Write-Host "Installed Media Player Classic" }
    $ResultText.text = "`r`n" + "Finished Installing Media Player Classic" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$7zip.Add_Click({
    Write-Host "Installing 7-Zip Compression Tool"
    $ResultText.text = "`r`n" +"`r`n" + "Installing 7-Zip Compression Tool... Please Wait" 
    winget install -e 7zip.7zip | Out-Host
    if($?) { Write-Host "Installed 7-Zip Compression Tool" }
    $ResultText.text = "`r`n" + "Finished Installing 7-Zip Compression Tool" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$vscode.Add_Click({
    Write-Host "Installing Visual Studio Code"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Visual Studio Code... Please Wait" 
    winget install -e Microsoft.VisualStudioCode --source winget | Out-Host
    if($?) { Write-Host "Installed Visual Studio Code" }
    $ResultText.text = "`r`n" + "Finished Installing Visual Studio Code" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$vscodium.Add_Click({
    Write-Host "Installing VS Codium"
    $ResultText.text = "`r`n" +"`r`n" + "Installing VS Codium... Please Wait" 
    winget install -e VSCodium.VSCodium | Out-Host
    if($?) { Write-Host "Installed VS Codium" }
    $ResultText.text = "`r`n" + "Finished Installing VS Codium" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$urlremovevirus.Add_Click({
    Start-Process "https://youtu.be/CHtZ9-9ch2w"
})

$urlfixwinstartup.Add_Click({
    Start-Process "https://youtu.be/sOihh4ZNOf4"
})

$urlcreateiso.Add_Click({
    Start-Process "https://youtu.be/R6XPff38iSc"
})

$winterminal.Add_Click({
    Write-Host "Installing New Windows Terminal"
    $ResultText.text = "`r`n" +"`r`n" + "Installing New Windows Terminal... Please Wait" 
    winget install -e Microsoft.WindowsTerminal | Out-Host
    if($?) { Write-Host "Installed New Windows Terminal" }
    $ResultText.text = "`r`n" + "Finished Installing New Windows Terminal" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$powertoys.Add_Click({
    Write-Host "Installing Microsoft PowerToys"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Microsoft PowerToys... Please Wait" 
    winget install -e Microsoft.PowerToys | Out-Host
    if($?) { Write-Host "Installed Microsoft PowerToys" }
    $ResultText.text = "`r`n" + "Finished Installing Microsoft PowerToys" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$everythingsearch.Add_Click({
    Write-Host "Installing Voidtools Everything Search"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Voidtools Everything Search... Please Wait" 
    winget install -e voidtools.Everything --source winget | Out-Host
    if($?) { Write-Host "Installed Everything Search" }
    $ResultText.text = "`r`n" + "Finished Installing Voidtools Everything Search" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$sumatrapdf.Add_Click({
    Write-Host "Installing Sumatra PDF"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Sumatra PDF... Please Wait" 
    winget install -e SumatraPDF.SumatraPDF | Out-Host
    if($?) { Write-Host "Installed Sumatra PDF" }
    $ResultText.text = "`r`n" + "Finished Installing Sumatra PDF" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$githubdesktop.Add_Click({
    Write-Host "Installing Git and GitHub Desktop"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Git and GitHub Desktop... Please Wait" 
    winget install -e Git.Git | Out-Host
    winget install -e GitHub.GitHubDesktop | Out-Host
    Write-Host "Installed Git and Github Desktop"
    $ResultText.text = "`r`n" + "Finished Installing Git and GitHub Desktop" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$translucenttb.Add_Click({
    Write-Host "Installing Translucent Taskbar"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Translucent Taskbar... Please Wait" 
    winget install -e TranslucentTB.TranslucentTB | Out-Host
    Write-Host "Installed Translucent Taskbar"
    $ResultText.text = "`r`n" + "Finished Installing Translucent Taskbar" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$etcher.Add_Click({
    Write-Host "Installing Etcher USB Imager"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Etcher USB Imager... Please Wait" 
    winget install -e Balena.Etcher | Out-Host
    Write-Host "Installed Etcher USB Imager"
    $ResultText.text = "`r`n" + "Finished Installing Etcher USB Imager" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$putty.Add_Click({
    Write-Host "Installing PuTTY & WinSCP"
    $ResultText.text = "`r`n" +"`r`n" + "Installing PuTTY & WinSCP... Please Wait" 
    winget install -e PuTTY.PuTTY | Out-Host
    winget install -e WinSCP.WinSCP | Out-Host
    Write-Host "Installed PuTTY & WinSCP"
    $ResultText.text = "`r`n" + "Finished Installing PuTTY & WinSCP" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$advancedipscanner.Add_Click({
    Write-Host "Installing Advanced IP Scanner"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Advanced IP Scanner... Please Wait" 
    winget install -e Famatech.AdvancedIPScanner | Out-Host
    Write-Host "Installed Advanced IP Scanner"
    $ResultText.text = "`r`n" + "Finished Installing Advanced IP Scanner" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$sharex.Add_Click({
    Write-Host "Installing ShareX Screenshot Tool"
    $ResultText.text = "`r`n" +"`r`n" + "Installing ShareX Screenshot Tool... Please Wait" 
    winget install -e ShareX.ShareX | Out-Host
    Write-Host "Installed ShareX Screenshot Tool"
    $ResultText.text = "`r`n" + "Finished Installing ShareX Screenshot Tool" + "`r`n" + "`r`n" + "Ready for Next Task"
})

$gimp.Add_Click({
    Write-Host "Installing Gimp Image Editor"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Gimp Image Editor... Please Wait" 
    winget install -e GIMP.GIMP | Out-Host
    Write-Host "Installed Gimp Image Editor"
    $ResultText.text = "`r`n" + "Finished Installing Gimp Image Editor" + "`r`n" + "`r`n" + "Ready for Next Task"
})
