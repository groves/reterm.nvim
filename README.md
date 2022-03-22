Lua function to execute the last command issued in a Neovim terminal

API
---
`require('reterm')()`

Send the ["cursor up" ANSI control sequence](https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797#cursor-controls) -- `ESC]A` -- and a carriage return to the last terminal reterm sent to. If we haven't sent to a terminal yet or if the last sent to terminal no longer exists, send to a random terminal. Fails if there are no terminals active.

`require('reterm')({now=true})`

Pick a terminal as described above, send it `<Ctrl-c>` and then cursor up and carriage return as above.

`require('reterm')({job_id=6})`

Send cursor up and carriage return to job_id 6. Fails if job_id 6 isn't a terminal job. If it succeeds, job_id 6 becomes the default if job_id isn't provided.

`require('reterm')({job_id=6, now=true})`

Send `<Ctrl-c>`, cursor up, and carriage return to job_id 6. Fails if job_id 6 isn't a terminal job.
