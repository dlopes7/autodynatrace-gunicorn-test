import time
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    time.sleep(1)
    return {"message": "Hello World"}
