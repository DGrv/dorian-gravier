from optparse import OptionParser, OptionGroup
import glob
import re

parser = OptionParser('usage: %prog [options] input-file.mp? ')
# parser.add_option('-i', '--input', action='store', type='string', dest='inputfile', default=None, help='Your Input file')
parser.add_option('-l', '--language', action='store', type='string', dest='lan_in', default=None, help='Language of the file')
parser.add_option('-m', '--model', action='store', type='string', dest='modelwhisper', default='medium', help='Model of whisper: tiny, base, small, medium, large or even tiny.en, base.en, small.en, medium.en for english models')
(options, args) = parser.parse_args()

# print(options.modelwhisper)
# print(options.lan_in)
outputsrt = re.sub("mp3$|mp4$", "srt", args[0])
outputsrt_en = re.sub(".mp3$|.mp4$", "_EN.srt", args[0])
# print(outputsrt)

print("Load whisper ...")
import whisper 
print("Done. Continue...")
from stable_whisper import modify_model
from stable_whisper import results_to_sentence_srt
from stable_whisper import results_to_word_srt







if len(args) < 1:
    parser.print_help()
    exit(2)


model1 = whisper.load_model(options.modelwhisper)
# normal whisper
# result1 = model.transcribe('test.mp3', language='fr', max_initial_timestamp=None)
modify_model(model1)
# with stable-ts 
# result2 = model1.transcribe(glob.iglob(args[0]), language=options.lan_in)
result2 = model1.transcribe(args[0], language=options.lan_in, suppress_silence=True, ts_num=16, lower_quantile=0.05, lower_threshold=0.1)
# result3 = model.transcribe('test.mp3', language='fr', suppress_silence=True, ts_num=16, lower_quantile=0.05, lower_threshold=0.1)
# result4 = model.transcribe('test.mp3', language='fr',   task = "translate")

# result2.keys()
# result2['text']

# sentence/phrase-level
# after you get results from modified model
results_to_sentence_srt(result2, outputsrt)
# below is from large model default settings

result3 = model1.transcribe(args[0], language=options.lan_in, task = 'translate', suppress_silence=True, ts_num=16, lower_quantile=0.05, lower_threshold=0.1)
results_to_sentence_srt(result3, outputsrt_en)











