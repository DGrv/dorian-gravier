print("Load whisper ...")
import whisper 
print("Done. Continue...")
from stable_whisper import modify_model
from stable_whisper import results_to_sentence_srt
from stable_whisper import results_to_word_srt


model1 = whisper.load_model('medium')
# normal whisper
# result1 = model.transcribe('test.mp4', language='fr', max_initial_timestamp=None)
modify_model(model1)


result01 = model1.transcribe('test.mp3', language='fr', pbar=True, suppress_silence=False) 
results_to_sentence_srt(result01, 'test01.srt')
result02 = model1.transcribe('test.mp3', language='fr', pbar=True, suppress_silence=True)
results_to_sentence_srt(result02, 'test02.srt')
result03 = model1.transcribe('test.mp3', language='fr', pbar=True, suppress_silence=False, ts_num=16)
results_to_sentence_srt(result03, 'test03.srt')
result04 = model1.transcribe('test.mp3', language='fr', pbar=True, suppress_silence=True, ts_num=16)
results_to_sentence_srt(result04, 'test04.srt')
result05 = model1.transcribe('test.mp3', language='fr', pbar=True, suppress_silence=False, ts_num=16, lower_quantile=0.05, lower_threshold=0.1)  
results_to_sentence_srt(result05, 'test05.srt')
result06 = model1.transcribe('test.mp3', language='fr', pbar=True, suppress_silence=False, ts_num=16, lower_quantile=0.15, lower_threshold=0.1)
results_to_sentence_srt(result06, 'test06.srt')
result07 = model1.transcribe('test.mp3', language='fr', pbar=True, suppress_silence=False, ts_num=16, lower_quantile=0.05, lower_threshold=0.2)
results_to_sentence_srt(result07, 'test07.srt')
result08 = model1.transcribe('test.mp3', language='fr', pbar=True, suppress_silence=False, ts_num=16, lower_quantile=0.15, lower_threshold=0.2)
results_to_sentence_srt(result08, 'test08.srt')
result09 = model1.transcribe('test.mp3', language='fr', pbar=True, suppress_silence=False, ts_num=16, lower_quantile=0.05, lower_threshold=0.3)
results_to_sentence_srt(result09, 'test09.srt')
result10 = model1.transcribe('test.mp3', language='fr', pbar=True, suppress_silence=False, ts_num=16, lower_quantile=0.15, lower_threshold=0.3)
results_to_sentence_srt(result10, 'test10.srt')

