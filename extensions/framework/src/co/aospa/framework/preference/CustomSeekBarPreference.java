/*
 * Copyright (C) 2016-2017 The Dirty Unicorns Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License
 */

package co.aospa.framework.preference;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.PorterDuff;
import android.util.AttributeSet;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.widget.ImageView;
import android.widget.SeekBar;
import android.widget.TextView;
import android.widget.Toast;

import androidx.core.content.res.TypedArrayUtils;
import androidx.preference.*;

import co.aospa.framework.R;

public class CustomSeekBarPreference extends Preference implements SeekBar.OnSeekBarChangeListener,
        View.OnClickListener, View.OnLongClickListener {
    protected final String TAG = getClass().getName();
    private static final String SETTINGS_NS = "http://schemas.android.com/apk/res/com.android.settings";
    private static final String SETTINGS_NS_ALT = "http://schemas.android.com/apk/res-auto";
    protected static final String ANDROIDNS = "http://schemas.android.com/apk/res/android";

    protected int mInterval = 1;
    protected boolean mShowSign = false;
    protected String mUnits = "";
    protected boolean mContinuousUpdates = false;
    protected String mTextStart, mTextEnd;
    protected boolean mShowButtons;

    protected int mMinValue = 0;
    protected int mMaxValue = 100;
    protected int mDefaultValue;

    protected int mValue;

    protected TextView mValueTextView;
    protected ImageView mResetImageView;
    protected ImageView mMinusImageView;
    protected ImageView mPlusImageView;
    protected SeekBar mSeekBar;

    protected boolean mTrackingTouch = false;
    protected int mTrackingValue;

    public CustomSeekBarPreference(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);

        TypedArray a = context.obtainStyledAttributes(attrs, R.styleable.CustomSeekBarPreference);
        try {
            mShowSign = a.getBoolean(R.styleable.CustomSeekBarPreference_showSign, mShowSign);
            String units = a.getString(R.styleable.CustomSeekBarPreference_units);
            if (units != null) mUnits = units;
            mContinuousUpdates = a.getBoolean(
                    R.styleable.CustomSeekBarPreference_continuousUpdates, false);
            mTextStart = a.getString(R.styleable.CustomSeekBarPreference_textStart);
            mTextEnd = a.getString(R.styleable.CustomSeekBarPreference_textEnd);
            mShowButtons = a.getBoolean(R.styleable.CustomSeekBarPreference_showButtons, true);
        } finally {
            a.recycle();
        }

        try {
            String newInterval = attrs.getAttributeValue(SETTINGS_NS, "interval");
            if (newInterval != null) {
                mInterval = Integer.parseInt(newInterval);
            } else {
                newInterval = attrs.getAttributeValue(SETTINGS_NS_ALT, "interval");
                if (newInterval != null) mInterval = Integer.parseInt(newInterval);
            }
        } catch (Exception e) {
            Log.e(TAG, "Invalid interval value", e);
        }
        mMinValue = attrs.getAttributeIntValue(SETTINGS_NS, "min", mMinValue);
        if (mMinValue == 0) {
            int min = attrs.getAttributeIntValue(SETTINGS_NS_ALT, "min", mMinValue);
            if (min != 0) mMinValue = min;
        }
        mMaxValue = attrs.getAttributeIntValue(ANDROIDNS, "max", mMaxValue);
        if (mMaxValue < mMinValue)
            mMaxValue = mMinValue;

        setLayoutResource(R.layout.preference_custom_seekbar);
    }

    public CustomSeekBarPreference(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, 0);
    }

    public CustomSeekBarPreference(Context context, AttributeSet attrs) {
        this(context, attrs, TypedArrayUtils.getAttr(context,
                androidx.preference.R.attr.preferenceStyle,
                android.R.attr.preferenceStyle));
    }

    public CustomSeekBarPreference(Context context) {
        this(context, null);
    }

    @Override
    public void onBindViewHolder(PreferenceViewHolder holder) {
        super.onBindViewHolder(holder);

        mSeekBar = (SeekBar) holder.findViewById(R.id.seekbar);
        mSeekBar.setMax(getSeekValue(mMaxValue));
        mSeekBar.setProgress(getSeekValue(mValue));
        mSeekBar.setEnabled(isEnabled());

        mValueTextView = (TextView) holder.findViewById(R.id.value);
        mResetImageView = (ImageView) holder.findViewById(R.id.reset);
        mMinusImageView = (ImageView) holder.findViewById(R.id.minus);
        mPlusImageView = (ImageView) holder.findViewById(R.id.plus);

        if (mTextEnd != null || mTextStart != null) {
            holder.findViewById(R.id.label_frame).setVisibility(View.VISIBLE);
            TextView startText = (TextView) holder.findViewById(android.R.id.text1);
            TextView endText = (TextView) holder.findViewById(android.R.id.text2);
            startText.setText(mTextStart);
            endText.setText(mTextEnd);
        }

        if (!mShowButtons) {
            mMinusImageView.setVisibility(View.GONE);
            mPlusImageView.setVisibility(View.GONE);
        }

        updateValueViews();

        mSeekBar.setOnSeekBarChangeListener(this);
        mResetImageView.setOnClickListener(this);
        mMinusImageView.setOnClickListener(this);
        mPlusImageView.setOnClickListener(this);
        mResetImageView.setOnLongClickListener(this);
        mMinusImageView.setOnLongClickListener(this);
        mPlusImageView.setOnLongClickListener(this);
    }

    protected int getLimitedValue(int v) {
        return v < mMinValue ? mMinValue : (v > mMaxValue ? mMaxValue : v);
    }

    protected int getSeekValue(int v) {
        return 0 - Math.floorDiv(mMinValue - v, mInterval);
    }

    protected String getTextValue(int v) {
        return String.valueOf(v) + mUnits;
    }

    protected void updateValueViews() {
        if (mValueTextView != null) {
            String textValue = getTextValue(mValue);
            if (mTrackingTouch && !mContinuousUpdates) {
                textValue = getTextValue(mTrackingValue);
            }
            mValueTextView.setText(textValue);
        }

        if (mResetImageView != null) {
            if (mValue == mDefaultValue || mTrackingTouch)
                mResetImageView.setVisibility(View.INVISIBLE);
            else
                mResetImageView.setVisibility(View.VISIBLE);
        }

        if (mMinusImageView != null) {
            if (mValue == mMinValue || mTrackingTouch) {
                mMinusImageView.setClickable(false);
                mMinusImageView.setColorFilter(getContext().getColor(R.color.disabled_text_color),
                        PorterDuff.Mode.MULTIPLY);
            } else {
                mMinusImageView.setClickable(true);
                mMinusImageView.clearColorFilter();
            }
        }

        if (mPlusImageView != null) {
            if (mValue == mMaxValue || mTrackingTouch) {
                mPlusImageView.setClickable(false);
                mPlusImageView.setColorFilter(getContext().getColor(R.color.disabled_text_color),
                        PorterDuff.Mode.MULTIPLY);
            } else {
                mPlusImageView.setClickable(true);
                mPlusImageView.clearColorFilter();
            }
        }
    }

    protected void changeValue(int newValue) {
        // for subclasses
    }

    @Override
    public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
        int newValue = getLimitedValue(mMinValue + (progress * mInterval));
        if (mTrackingTouch && !mContinuousUpdates) {
            mTrackingValue = newValue;
            updateValueViews();
        } else if (mValue != newValue) {
            // change rejected, revert to the previous value
            if (!callChangeListener(newValue)) {
                mSeekBar.setProgress(getSeekValue(mValue));
                return;
            }
            // change accepted, store it
            changeValue(newValue);
            persistInt(newValue);

            mValue = newValue;
            updateValueViews();
        }
    }

    @Override
    public void onStartTrackingTouch(SeekBar seekBar) {
        mTrackingValue = mValue;
        mTrackingTouch = true;
    }

    @Override
    public void onStopTrackingTouch(SeekBar seekBar) {
        mTrackingTouch = false;
        if (!mContinuousUpdates)
            onProgressChanged(mSeekBar, getSeekValue(mTrackingValue), false);
        notifyChanged();
    }

    @Override
    public void onClick(View v) {
        int id = v.getId();
        if (id == R.id.reset) {
            Toast.makeText(getContext(), getContext().getString(
                    R.string.custom_seekbar_default_value_to_set, getTextValue(mDefaultValue)),
                    Toast.LENGTH_LONG).show();
        } else if (id == R.id.minus) {
            setValue(mValue - mInterval, true);
        } else if (id == R.id.plus) {
            setValue(mValue + mInterval, true);
        }
    }

    @Override
    public boolean onLongClick(View v) {
        int id = v.getId();
        if (id == R.id.reset) {
            setValue(mDefaultValue, true);
        } else if (id == R.id.minus) {
            int value = mMinValue;
            if (mMaxValue - mMinValue > mInterval * 2 && mMaxValue + mMinValue < mValue * 2) {
                value = Math.floorDiv(mMaxValue + mMinValue, 2);
            }
            setValue(value, true);
        } else if (id == R.id.plus) {
            int value = mMaxValue;
            if (mMaxValue - mMinValue > mInterval * 2 && mMaxValue + mMinValue > mValue * 2) {
                value = -1 * Math.floorDiv(-1 * (mMaxValue + mMinValue), 2);
            }
            setValue(value, true);
        }
        return true;
    }

    @Override
    protected Object onGetDefaultValue(TypedArray ta, int index) {
        mDefaultValue = ta.getInt(index, mMinValue);
        return mDefaultValue;
    }

    @Override
    protected void onSetInitialValue(boolean restorePersistedValue, Object defaultValue) {
        mValue = getPersistedInt(mDefaultValue);
    }

    @Override
    public void setDefaultValue(Object defaultValue) {
        setDefaultValue((Integer) defaultValue, mSeekBar != null);
    }

    public void setDefaultValue(int newValue, boolean update) {
        newValue = getLimitedValue(newValue);
        if (mDefaultValue != newValue) {
            mDefaultValue = newValue;
            if (update)
                updateValueViews();
        }
    }

    public void setMax(int max) {
        mMaxValue = max;
        mSeekBar.setMax(mMaxValue - mMinValue);
    }

    public int getMax() {
        return mMaxValue;
    }

    public void setMin(int min) {
        mMinValue = min;
        mSeekBar.setMax(mMaxValue - mMinValue);
    }

    public void setValue(int newValue) {
        mValue = getLimitedValue(newValue);
        if (mSeekBar != null) mSeekBar.setProgress(getSeekValue(mValue));
    }

    public void setValue(int newValue, boolean update) {
        newValue = getLimitedValue(newValue);
        if (mValue != newValue) {
            if (update)
                mSeekBar.setProgress(getSeekValue(newValue));
            else
                mValue = newValue;
        }
    }

    public int getValue() {
        return mValue;
    }

    public void setUnits(String units) {
        mUnits = units;
        updateValueViews();
    }

    public String getUnits() {
        return mUnits;
    }

    // need some methods here to set/get other attrs at runtime,
    // but who really need this ...

    public void refresh(int newValue) {
        // this will ...
        setValue(newValue, mSeekBar != null);
    }
}
