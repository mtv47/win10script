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
$Form.text                       = "Windows Toolbox By mtv47"
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


# ------------------------------------------------------------------------------------------------
# Utilities Menu

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "Utilities"
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(89,11)
$Label2.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))


# Windows Terminal

$winterminal                     = New-Object system.Windows.Forms.Button
$winterminal.text                = "Windows Terminal"
$winterminal.width               = 211
$winterminal.height              = 30
$winterminal.location            = New-Object System.Drawing.Point(3,32)
$winterminal.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$winterminal.Add_Click({
    Write-Host "Installing New Windows Terminal"
    $ResultText.text = "`r`n" +"`r`n" + "Installing New Windows Terminal... Please Wait" 
    winget install -e Microsoft.WindowsTerminal | Out-Host
    if($?) { Write-Host "Installed New Windows Terminal" }
    $ResultText.text = "`r`n" + "Finished Installing New Windows Terminal" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# PowerToys

$powertoys                       = New-Object system.Windows.Forms.Button
$powertoys.text                  = "PowerToys"
$powertoys.width                 = 211
$powertoys.height                = 30
$powertoys.location              = New-Object System.Drawing.Point(4,67)
$powertoys.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$powertoys.Add_Click({
    Write-Host "Installing Microsoft PowerToys"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Microsoft PowerToys... Please Wait" 
    winget install -e Microsoft.PowerToys | Out-Host
    if($?) { Write-Host "Installed Microsoft PowerToys" }
    $ResultText.text = "`r`n" + "Finished Installing Microsoft PowerToys" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# 7-Zip

$7zip                            = New-Object system.Windows.Forms.Button
$7zip.text                       = "7-Zip"
$7zip.width                      = 211
$7zip.height                     = 30
$7zip.location                   = New-Object System.Drawing.Point(4,102)
$7zip.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$7zip.Add_Click({
    Write-Host "Installing 7-Zip Compression Tool"
    $ResultText.text = "`r`n" +"`r`n" + "Installing 7-Zip Compression Tool... Please Wait" 
    winget install -e 7zip.7zip | Out-Host
    if($?) { Write-Host "Installed 7-Zip Compression Tool" }
    $ResultText.text = "`r`n" + "Finished Installing 7-Zip Compression Tool" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# Etcher

$etcher                          = New-Object system.Windows.Forms.Button
$etcher.text                     = "Etcher USB Creator"
$etcher.width                    = 211
$etcher.height                   = 30
$etcher.location                 = New-Object System.Drawing.Point(4,136)
$etcher.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$etcher.Add_Click({
    Write-Host "Installing Etcher USB Imager"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Etcher USB Imager... Please Wait" 
    winget install -e Balena.Etcher | Out-Host
    Write-Host "Installed Etcher USB Imager"
    $ResultText.text = "`r`n" + "Finished Installing Etcher USB Imager" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# Putty

$putty                           = New-Object system.Windows.Forms.Button
$putty.text                      = "PuTTY & WinSCP"
$putty.width                     = 211
$putty.height                    = 30
$putty.location                  = New-Object System.Drawing.Point(4,170)
$putty.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$putty.Add_Click({
    Write-Host "Installing PuTTY & WinSCP"
    $ResultText.text = "`r`n" +"`r`n" + "Installing PuTTY & WinSCP... Please Wait" 
    winget install -e PuTTY.PuTTY | Out-Host
    winget install -e WinSCP.WinSCP | Out-Host
    Write-Host "Installed PuTTY & WinSCP"
    $ResultText.text = "`r`n" + "Finished Installing PuTTY & WinSCP" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# Advanced IP Scanner

$advancedipscanner               = New-Object system.Windows.Forms.Button
$advancedipscanner.text          = "Advanced IP Scanner"
$advancedipscanner.width         = 211
$advancedipscanner.height        = 30
$advancedipscanner.location      = New-Object System.Drawing.Point(3,203)
$advancedipscanner.Font          = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$advancedipscanner.Add_Click({
    Write-Host "Installing Advanced IP Scanner"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Advanced IP Scanner... Please Wait" 
    winget install -e Famatech.AdvancedIPScanner | Out-Host
    Write-Host "Installed Advanced IP Scanner"
    $ResultText.text = "`r`n" + "Finished Installing Advanced IP Scanner" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# CPU-Z

$cpuZ                            = New-Object system.Windows.Forms.Button
$cpuZ.text                       = "CPU-Z"
$cpuZ.width                      = 211
$cpuZ.height                     = 30
$cpuZ.location                   = New-Object System.Drawing.Point(3,237)
$cpuZ.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$cpuZ.Add_Click({
    Write-Host "Installing CPU-Z"
    $ResultText.text = "`r`n" +"`r`n" + "Installing CPU-Z... Please Wait" 
    winget install -e CPUID.CPU-Z | Out-Host
    Write-Host "Installed CPU-Z"
    $ResultText.text = "`r`n" + "Finished Installing CPU-Z" + "`r`n" + "`r`n" + "Ready for Next Task"
})

# GPU-Z

$gpuZ                            = New-Object system.Windows.Forms.Button
$gpuZ.text                       = "GPU-Z"
$gpuZ.width                      = 211
$gpuZ.height                     = 30
$gpuZ.location                   = New-Object System.Drawing.Point(3,271)
$gpuZ.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$gpuZ.Add_Click({
    Write-Host "Installing GPU-Z"
    $ResultText.text = "`r`n" +"`r`n" + "Installing GPU-Z... Please Wait" 
    winget install -e TechPowerUp.GPU-Z | Out-Host
    Write-Host "Installed GPU-Z"
    $ResultText.text = "`r`n" + "Finished Installing GPU-Z" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# HWiNFO

$hwinfotool                      = New-Object system.Windows.Forms.Button
$hwinfotool.text                 = "HWiNFO"
$hwinfotool.width                = 211
$hwinfotool.height               = 30
$hwinfotool.location             = New-Object System.Drawing.Point(3,305)
$hwinfotool.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$hwinfotool.Add_Click({
    Write-Host "Installing HWiNFO"
    $ResultText.text = "`r`n" +"`r`n" + "Installing HWiNFO... Please Wait" 
    winget install -e HWiNFO.HWiNFO | Out-Host
    Write-Host "Installed HWiNFO"
    $ResultText.text = "`r`n" + "Finished Installing HWiNFO" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# CrystalDiskInfo

$crystaldiskinfo                 = New-Object system.Windows.Forms.Button
$crystaldiskinfo.text            = "CrystalDiskInfo"
$crystaldiskinfo.width           = 211
$crystaldiskinfo.height          = 30
$crystaldiskinfo.location        = New-Object System.Drawing.Point(3,339)
$crystaldiskinfo.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$crystaldiskinfo.Add_Click({
    Write-Host "Installing CrystalDiskInfo"
    $ResultText.text = "`r`n" +"`r`n" + "Installing CrystalDiskInfo... Please Wait" 
    winget install -e CrystalDewWorld.CrystalDiskInfo | Out-Host
    Write-Host "Installed CrystalDiskInfo"
    $ResultText.text = "`r`n" + "Finished Installing CrystalDiskInfo" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# Discord

$discord                         = New-Object system.Windows.Forms.Button
$discord.text                    = "Discord"
$discord.width                   = 211
$discord.height                  = 30
$discord.location                = New-Object System.Drawing.Point(3,368)
$discord.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$discord.Add_Click({
    Write-Host "Installing Discord"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Discord... Please Wait" 
    winget install -e Discord.Discord | Out-Host
    if($?) { Write-Host "Installed Discord" }
    $ResultText.text = "`r`n" + "Finished Installing Discord" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# ------------------------------------------------------------------------------------------------
# Web Browsers Menu
$Label9                          = New-Object system.Windows.Forms.Label
$Label9.text                     = "Web Browsers"
$Label9.AutoSize                 = $true
$Label9.width                    = 25
$Label9.height                   = 10
$Label9.location                 = New-Object System.Drawing.Point(67,406)
$Label9.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))


# Brave

$brave                           = New-Object system.Windows.Forms.Button
$brave.text                      = "Brave Browser"
$brave.width                     = 212
$brave.height                    = 30
$brave.location                  = New-Object System.Drawing.Point(4,426)
$brave.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$brave.Add_Click({
    Write-Host "Installing Brave Browser"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Brave... Please Wait" 
    winget install -e BraveSoftware.BraveBrowser | Out-Host
    if($?) { Write-Host "Installed Brave Browser" }
    $ResultText.text = "`r`n" + "Finished Installing Brave" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# Firefox

$firefox                         = New-Object system.Windows.Forms.Button
$firefox.text                    = "Firefox"
$firefox.width                   = 212
$firefox.height                  = 30
$firefox.location                = New-Object System.Drawing.Point(4,461)
$firefox.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$firefox.Add_Click({
    Write-Host "Installing Firefox"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Firefox... Please Wait" 
    winget install -e Mozilla.Firefox | Out-Host
    if($?) { Write-Host "Installed Firefox" }
    $ResultText.text = "`r`n" + "Finished Installing Firefox" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# Chrome

$gchrome                         = New-Object system.Windows.Forms.Button
$gchrome.text                    = "Google Chrome"
$gchrome.width                   = 212
$gchrome.height                  = 30
$gchrome.location                = New-Object System.Drawing.Point(3,494)
$gchrome.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$gchrome.Add_Click({
    Write-Host "Installing Google Chrome"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Google Chrome... Please Wait" 
    winget install -e Google.Chrome | Out-Host
    if($?) { Write-Host "Installed Google Chrome" }
    $ResultText.text = "`r`n" + "Finished Installing Google Chrome" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# ------------------------------------------------------------------------------------------------
# Video and Image Menu
$Label8                          = New-Object system.Windows.Forms.Label
$Label8.text                     = "Video and Image Tools"
$Label8.AutoSize                 = $true
$Label8.width                    = 25
$Label8.height                   = 10
$Label8.location                 = New-Object System.Drawing.Point(41,537)
$Label8.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))


# GIMP

$gimp                            = New-Object system.Windows.Forms.Button
$gimp.text                       = "GIMP (Image Editor)"
$gimp.width                      = 212
$gimp.height                     = 30
$gimp.location                   = New-Object System.Drawing.Point(3,561)
$gimp.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$gimp.Add_Click({
    Write-Host "Installing Gimp Image Editor"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Gimp Image Editor... Please Wait" 
    winget install -e GIMP.GIMP | Out-Host
    Write-Host "Installed Gimp Image Editor"
    $ResultText.text = "`r`n" + "Finished Installing Gimp Image Editor" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# VLC

$vlc                             = New-Object system.Windows.Forms.Button
$vlc.text                        = "VLC"
$vlc.width                       = 212
$vlc.height                      = 30
$vlc.location                    = New-Object System.Drawing.Point(4,595)
$vlc.Font                        = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$vlc.Add_Click({
    Write-Host "Installing VLC Media Player"
    $ResultText.text = "`r`n" +"`r`n" + "Installing VLC Media Player... Please Wait" 
    winget install -e VideoLAN.VLC | Out-Host
    if($?) { Write-Host "Installed VLC Media Player" }
    $ResultText.text = "`r`n" + "Finished Installing VLC Media Player" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# ------------------------------------------------------------------------------------------------
# Coding Menu

$Label7                          = New-Object system.Windows.Forms.Label
$Label7.text                     = "Coding Tools"
$Label7.AutoSize                 = $true
$Label7.width                    = 25
$Label7.height                   = 10
$Label7.location                 = New-Object System.Drawing.Point(60,740)
$Label7.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))


# Github Desktop

$githubdesktop                   = New-Object system.Windows.Forms.Button
$githubdesktop.text              = "Github Desktop"
$githubdesktop.width             = 211
$githubdesktop.height            = 30
$githubdesktop.location          = New-Object System.Drawing.Point(4,763)
$githubdesktop.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$githubdesktop.Add_Click({
    Write-Host "Installing Git and GitHub Desktop"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Git and GitHub Desktop... Please Wait" 
    winget install -e Git.Git | Out-Host
    winget install -e GitHub.GitHubDesktop | Out-Host
    Write-Host "Installed Git and Github Desktop"
    $ResultText.text = "`r`n" + "Finished Installing Git and GitHub Desktop" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# VS Code

$vscode                          = New-Object system.Windows.Forms.Button
$vscode.text                     = "VS Code"
$vscode.width                    = 211
$vscode.height                   = 30
$vscode.location                 = New-Object System.Drawing.Point(4,797)
$vscode.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$vscode.Add_Click({
    Write-Host "Installing Visual Studio Code"
    $ResultText.text = "`r`n" +"`r`n" + "Installing Visual Studio Code... Please Wait" 
    winget install -e Microsoft.VisualStudioCode --source winget | Out-Host
    if($?) { Write-Host "Installed Visual Studio Code" }
    $ResultText.text = "`r`n" + "Finished Installing Visual Studio Code" + "`r`n" + "`r`n" + "Ready for Next Task"
})


# ------------------------------------------------------------------------------------------------
# Not finished Menu

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

$darkmode                        = New-Object system.Windows.Forms.Button
$darkmode.text                   = "Dark Mode"
$darkmode.width                  = 205
$darkmode.height                 = 30
$darkmode.location               = New-Object System.Drawing.Point(3,176)
$darkmode.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$performancefx                   = New-Object system.Windows.Forms.Button
$performancefx.text              = "Performance Visual FX"
$performancefx.width             = 205
$performancefx.height            = 30
$performancefx.location          = New-Object System.Drawing.Point(3,419)
$performancefx.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

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

$securitywindowsupdate           = New-Object system.Windows.Forms.Button
$securitywindowsupdate.text      = "Security Updates Only"
$securitywindowsupdate.width     = 300
$securitywindowsupdate.height    = 30
$securitywindowsupdate.location  = New-Object System.Drawing.Point(24,142)
$securitywindowsupdate.Font      = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$lightmode                       = New-Object system.Windows.Forms.Button
$lightmode.text                  = "Light Mode"
$lightmode.width                 = 205
$lightmode.height                = 30
$lightmode.location              = New-Object System.Drawing.Point(3,210)
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

$appearancefx                    = New-Object system.Windows.Forms.Button
$appearancefx.text               = "Appearance Visual FX"
$appearancefx.width              = 205
$appearancefx.height             = 30
$appearancefx.location           = New-Object System.Drawing.Point(4,385)
$appearancefx.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

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

$oldpower                        = New-Object system.Windows.Forms.Button
$oldpower.text                   = "Win7 Power Panel"
$oldpower.width                  = 211
$oldpower.height                 = 30
$oldpower.location               = New-Object System.Drawing.Point(4,227)
$oldpower.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Form.controls.AddRange(@($Panel1,$Panel2,$Label3,$Label15,$Panel4,$Label1,$Panel3,$ResultText,$Label10))
$Panel1.controls.AddRange(@($brave,$firefox,$7zip,$adobereade,$gchrome,$vlc,$powertoys,$winterminal,$vscode,$Label2,$gimp,$Label7,$Label8,$Label9,$advancedipscanner,$putty,$etcher,$githubdesktop,$discord,$cpuZ,$gpuZ,$hwinfotool,$CrystalDiskInfo))
$Panel2.controls.AddRange(@($darkmode,$performancefx,$lightmode,$removebloat,$reinstallbloat,$WarningLabel,$Label5,$appearancefx))
$Panel4.controls.AddRange(@($securitywindowsupdate,$windowsupdatefix))
$Panel3.controls.AddRange(@($ncpa,$oldcontrolpanel,$oldsoundpanel,$oldsystempanel,$oldpower))


$Bloatware = @(
    #Unnecessary Windows 10 AppX Apps
    "Microsoft.3DBuilder"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.AppConnector"
    "Microsoft.BingFinance"
    "Microsoft.BingNews"
    "Microsoft.BingSports"
    "Microsoft.BingTranslator"
    "Microsoft.BingWeather"
    "Microsoft.BingFoodAndDrink"
    "Microsoft.BingHealthAndFitness"
    "Microsoft.BingTravel"
    "Microsoft.MinecraftUWP"
    "Microsoft.GamingServices"
    # "Microsoft.WindowsReadingList"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.Messaging"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.NetworkSpeedTest"
    "Microsoft.News"
    "Microsoft.Office.Lens"
    "Microsoft.Office.Sway"
    "Microsoft.Office.OneNote"
    "Microsoft.OneConnect"
    "Microsoft.People"
    "Microsoft.Print3D"
    "Microsoft.SkypeApp"
    "Microsoft.Wallet"
    "Microsoft.Whiteboard"
    "Microsoft.WindowsAlarms"
    "microsoft.windowscommunicationsapps"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    "Microsoft.WindowsPhone"
    "Microsoft.WindowsSoundRecorder"
    "Microsoft.XboxApp"
    "Microsoft.ConnectivityStore"
    "Microsoft.CommsPhone"
    "Microsoft.ScreenSketch"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxGameCallableUI"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.MixedReality.Portal"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "Microsoft.YourPhone"
    "Microsoft.Getstarted"
    "Microsoft.MicrosoftOfficeHub"

    #Sponsored Windows 10 AppX Apps
    #Add sponsored/featured apps to remove in the "*AppName*" format
    "*EclipseManager*"
    "*ActiproSoftwareLLC*"
    "*AdobeSystemsIncorporated.AdobePhotoshopExpress*"
    "*Duolingo-LearnLanguagesforFree*"
    "*PandoraMediaInc*"
    "*CandyCrush*"
    "*BubbleWitch3Saga*"
    "*Wunderlist*"
    "*Flipboard*"
    "*Twitter*"
    "*Facebook*"
    "*Royal Revolt*"
    "*Sway*"
    "*Speed Test*"
    "*Dolby*"
    "*Viber*"
    "*ACGMediaPlayer*"
    "*Netflix*"
    "*OneCalendar*"
    "*LinkedInforWindows*"
    "*HiddenCityMysteryofShadows*"
    "*Hulu*"
    "*HiddenCity*"
    "*AdobePhotoshopExpress*"
    "*HotspotShieldFreeVPN*"

    #Optional: Typically not removed but you can if you need to for some reason
    "*Microsoft.Advertising.Xaml*"
    #"*Microsoft.MSPaint*"
    #"*Microsoft.MicrosoftStickyNotes*"
    #"*Microsoft.Windows.Photos*"
    #"*Microsoft.WindowsCalculator*"
    #"*Microsoft.WindowsStore*"
)

$removebloat.Add_Click({
    Write-Host "Removing Bloatware"

    foreach ($Bloat in $Bloatware) {
        Get-AppxPackage -Name $Bloat| Remove-AppxPackage
        Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $Bloat | Remove-AppxProvisionedPackage -Online
        Write-Host "Trying to remove $Bloat."
        $ResultText.text = "`r`n" +"`r`n" + "Trying to remove $Bloat."
    }

    Write-Host "Finished Removing Bloatware Apps"
    $ResultText.text = "`r`n" +"`r`n" + "Finished Removing Bloatware Apps"
})

$reinstallbloat.Add_Click({
    Write-Host "Reinstalling Bloatware"

    foreach ($app in $Bloatware) {
        Write-Output "Trying to add $app"
        $ResultText.text = "`r`n" +"`r`n" + "Trying to add $app"
        Add-AppxPackage -DisableDevelopmentMode -Register "$($(Get-AppxPackage -AllUsers $app).InstallLocation)\AppXManifest.xml"
    }

    Write-Host "Finished Reinstalling Bloatware Apps"
    $ResultText.text = "`r`n" +"`r`n" + "Finished Reinstalling Bloatware Apps"
})

$securitywindowsupdate.Add_Click({
    Write-Host "Disabling driver offering through Windows Update..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -Type DWord -Value 1
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontPromptForWindowsUpdate" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontSearchWindowsUpdate" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DriverUpdateWizardWuSearchEnabled" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Type DWord -Value 1
    Write-Host "Disabling Windows Update automatic restart..."
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -Type DWord -Value 0
    Write-Host "Disabled driver offering through Windows Update"
    $ResultText.text = "`r`n" +"`r`n" + "Set Windows Update to Sane Settings"
})

$performancefx.Add_Click({
    Write-Host "Adjusting visual effects for performance..."
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "DragFullWindows" -Type String -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Type String -Value 200
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Type Binary -Value ([byte[]](144,18,3,128,16,0,0,0))
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Type String -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Type DWord -Value 3
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Type DWord -Value 0
    Write-Host "Adjusted visual effects for performance"
    $ResultText.text = "`r`n" +"`r`n" + "Adjusted VFX for performance"
})

$appearancefx.Add_Click({
	Write-Output "Adjusting visual effects for appearance..."
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "DragFullWindows" -Type String -Value 1
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Type String -Value 400
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Type Binary -Value ([byte[]](158,30,7,128,18,0,0,0))
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Type String -Value 1
	Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Type DWord -Value 3
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Type DWord -Value 1
    $ResultText.text = "`r`n" +"`r`n" + "Visual effects are set for appearance (Defaults)"
})

$darkmode.Add_Click({
    Write-Host "Enabling Dark Mode"
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0
    Write-Host "Enabled Dark Mode"
    $ResultText.text = "`r`n" +"`r`n" + "Enabled Dark Mode"
})

$lightmode.Add_Click({
    Write-Host "Switching Back to Light Mode"
    Remove-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme
    Write-Host "Switched Back to Light Mode"
    $ResultText.text = "`r`n" +"`r`n" + "Enabled Light Mode"
})

$ncpa.Add_Click({
    cmd /c ncpa.cpl
})
$oldsoundpanel.Add_Click({
    cmd /c mmsys.cpl
})
$oldcontrolpanel.Add_Click({
    cmd /c control
})
$oldsystempanel.Add_Click({
    cmd /c sysdm.cpl
})
$oldpower.Add_Click({
    cmd /c powercfg.cpl
})

$windowsupdatefix.Add_Click({
    Write-Host "1. Stopping Windows Update Services..." 
    Stop-Service -Name BITS 
    Stop-Service -Name wuauserv 
    Stop-Service -Name appidsvc 
    Stop-Service -Name cryptsvc 
    
    Write-Host "2. Remove QMGR Data file..." 
    Remove-Item "$env:allusersprofile\Application Data\Microsoft\Network\Downloader\qmgr*.dat" -ErrorAction SilentlyContinue 
    
    Write-Host "3. Renaming the Software Distribution and CatRoot Folder..." 
    Rename-Item $env:systemroot\SoftwareDistribution SoftwareDistribution.bak -ErrorAction SilentlyContinue 
    Rename-Item $env:systemroot\System32\Catroot2 catroot2.bak -ErrorAction SilentlyContinue 
    
    Write-Host "4. Removing old Windows Update log..." 
    Remove-Item $env:systemroot\WindowsUpdate.log -ErrorAction SilentlyContinue 
    
    Write-Host "5. Resetting the Windows Update Services to defualt settings..." 
    "sc.exe sdset bits D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)" 
    "sc.exe sdset wuauserv D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)" 
    
    Set-Location $env:systemroot\system32 
    
    Write-Host "6. Registering some DLLs..." 
    regsvr32.exe /s atl.dll 
    regsvr32.exe /s urlmon.dll 
    regsvr32.exe /s mshtml.dll 
    regsvr32.exe /s shdocvw.dll 
    regsvr32.exe /s browseui.dll 
    regsvr32.exe /s jscript.dll 
    regsvr32.exe /s vbscript.dll 
    regsvr32.exe /s scrrun.dll 
    regsvr32.exe /s msxml.dll 
    regsvr32.exe /s msxml3.dll 
    regsvr32.exe /s msxml6.dll 
    regsvr32.exe /s actxprxy.dll 
    regsvr32.exe /s softpub.dll 
    regsvr32.exe /s wintrust.dll 
    regsvr32.exe /s dssenh.dll 
    regsvr32.exe /s rsaenh.dll 
    regsvr32.exe /s gpkcsp.dll 
    regsvr32.exe /s sccbase.dll 
    regsvr32.exe /s slbcsp.dll 
    regsvr32.exe /s cryptdlg.dll 
    regsvr32.exe /s oleaut32.dll 
    regsvr32.exe /s ole32.dll 
    regsvr32.exe /s shell32.dll 
    regsvr32.exe /s initpki.dll 
    regsvr32.exe /s wuapi.dll 
    regsvr32.exe /s wuaueng.dll 
    regsvr32.exe /s wuaueng1.dll 
    regsvr32.exe /s wucltui.dll 
    regsvr32.exe /s wups.dll 
    regsvr32.exe /s wups2.dll 
    regsvr32.exe /s wuweb.dll 
    regsvr32.exe /s qmgr.dll 
    regsvr32.exe /s qmgrprxy.dll 
    regsvr32.exe /s wucltux.dll 
    regsvr32.exe /s muweb.dll 
    regsvr32.exe /s wuwebv.dll 
    
    Write-Host "7) Removing WSUS client settings..." 
    REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v AccountDomainSid /f 
    REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v PingID /f 
    REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /f 
    
    Write-Host "8) Resetting the WinSock..." 
    netsh winsock reset 
    netsh winhttp reset proxy 
    
    Write-Host "9) Delete all BITS jobs..." 
    Get-BitsTransfer | Remove-BitsTransfer 
    
    Write-Host "10) Attempting to install the Windows Update Agent..." 
    if($arch -eq 64){ 
        wusa Windows8-RT-KB2937636-x64 /quiet 
    } 
    else{ 
        wusa Windows8-RT-KB2937636-x86 /quiet 
    } 
    
    Write-Host "11) Starting Windows Update Services..." 
    Start-Service -Name BITS 
    Start-Service -Name wuauserv 
    Start-Service -Name appidsvc 
    Start-Service -Name cryptsvc 
    
    Write-Host "12) Forcing discovery..." 
    wuauclt /resetauthorization /detectnow 
    
    Write-Host "Process complete. Please reboot your computer."
    $ResultText.text = "`r`n" +"`r`n" + "Process complete. Please reboot your computer."

})

[void]$Form.ShowDialog()