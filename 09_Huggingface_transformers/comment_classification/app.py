# comment_classification/app.py
## Huggingface transformers.pipeline을 이용해서 한국어를 영어로 번역하는 app

import streamlit as st
from transformers import pipeline

# 처음 시작할 때 한 번 실행하고 반환되는 리소스를 메모리에 저장해 놓고, 다음부터는 그것을 사용
@st.cache_resource
def get_model():
    # model = "Helsinki-NLP/opus-mt-ko-en"
    # pipe=pipeline(task="translation",model=model)
    model = 'Copycats/koelectra-base-v3-generalized-sentiment-analysis'
    pipe=pipeline(task='text-classification', model=model)
    return pipe

# def translate_clear():
#     pass

def classify_and_clear():
    # print(f"classify_and_clear()--------------{st.session_state['input_text']}")
    # pipeline을 이용해서 입력된 댓글을 분류
    comment = st.session_state['input_text']
    if comment.strip():
        result = classifier(comment)[0]
        label = "긍정적 댓글" if result['label'] == '1' else "부정적 댓글"
        score = result['score']
        # session_state의 history에 추가
        st.session_state['history'].append((comment, f"{label}-{score:.3f}"))
        print(st.session_state['history'])
    # 댓글 입력 폼 내용 지우기
    st.session_state['input_text'] = ''


# translator = get_model()
classifier = get_model()

## 긍부정을 분류한 내역을 저장할 session state를 생성
# 어떤 값들을 계속 유지해야할 때 저장하는 공간(dict타입): session_state
if "history" not in st.session_state:
    st.session_state.history = [] # [(댓글1, 분류내역1), (댓글2, 분류내역2), ...]

# st.title("한국어 - 영어번역기")
# st.subheader("한국어 문장을 입력하면 영어로 번역해 드립니다.")
st.title("댓글 분석기")
st.subheader("댓글의 내용이 긍정적인지 부정적인지 분류합니다.")

# on_change: event handler (어떤 변화가 발생하면 함수를 호출)
##         - text 입력폼에 값이 바뀌고 엔터가 입력되면 함수를 호출
st.text_input(
    "분석할 한국어 문장을 입력하세요.",
    on_change=classify_and_clear,
    key='input_text' # session_state에 지정한 key로 등록되고 값은 입력폼의 value가 저장되어 동기화된다.
                     # session state값을 변경하면 입력 폼의 값이 변경. 반대도 마찬가지
)
st.button("분석", on_click=classify_and_clear)

# 댓글 분석 결과 출력
if st.session_state['history']:
    st.subheader("분석 결과")
    for comment, result in st.session_state['history'][::-1]:
        st.write(comment)
        st.write(result)
        st.write("---")