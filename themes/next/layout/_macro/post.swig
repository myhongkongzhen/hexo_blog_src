{% macro render(post, is_index, post_extra_class) %}

  {% set headlessPost = Array.prototype.indexOf.call(['quote', 'picture'], post.type) > -1 %}
  {% set navlessPost = headlessPost %}

  {% set post_class = 'post post-type-' + post.type | default('normal') %}
  {% set post_class = post_class + ' ' + post_extra_class | default('') %}
  {% if post.sticky > 0 %}
    {% set post_class = post_class + ' ' + 'post-sticky' %}
  {% endif %}

  <article class="{{ post_class }}" itemscope itemtype="http://schema.org/Article">

    {% if not headlessPost %}
      <header class="post-header">

        {# Not to show title for quote posts that do not have a title #}
        {% if not (is_index and post.type === 'quote' and not post.title) %}
          <h1 class="post-title" itemprop="name headline">
            {# Link posts #}
            {% if post.link %}
              {% if post.sticky > 0 %}
                {{ post.sticky }}
                <span class="post-sticky-flag" title="{{ __('post.sticky') }}">
                  <i class="fa fa-thumb-tack"></i>
                </span>
              {% endif %}
              <a class="post-title-link post-title-link-external" target="_blank" href="{{ url_for(post.link) }}" itemprop="url">
                {{ post.title or post.link }}
                <i class="fa fa-external-link"></i>
              </a>
            {% else %}
              {% if is_index %}
                {% if post.sticky > 0 %}
                  <span class="post-sticky-flag" title="{{ __('post.sticky') }}">
                    <i class="fa fa-thumb-tack"></i>
                  </span>
                {% endif %}
                <a class="post-title-link" href="{{ url_for(post.path) }}" itemprop="url">
                  {{ post.title | default(__('post.untitled'))}}
                </a>
              {% else %}
                {{ post.title }}
              {% endif %}
            {% endif %}
          </h1>
        {% endif %}

        <div class="post-meta">
          <span class="post-time">
            {{ __('post.posted') }}
            <time itemprop="dateCreated" datetime="{{ moment(post.date).format() }}" content="{{ date(post.date, config.date_format) }}">
              {{ date(post.date, config.date_format) }}
            </time>
          </span>

          {% if post.categories and post.categories.length %}
            <span class="post-category" >
              &nbsp; | &nbsp; {{ __('post.in') }}
              {% for cat in post.categories %}
                <span itemprop="about" itemscope itemtype="https://schema.org/Thing">
                  <a href="{{ url_for(cat.path) }}" itemprop="url" rel="index">
                    <span itemprop="name">{{ cat.name }}</span>
                  </a>
                </span>

                {% set cat_length = post.categories.length %}
                {% if cat_length > 1 and loop.index !== cat_length %}
                  {{ __('symbol.comma') }}
                {% endif %}

              {% endfor %}
            </span>
          {% endif %}

          {% if post.comments %}
            {% if (theme.duoshuo and theme.duoshuo.shortname) or theme.duoshuo_shortname %}
              <span class="post-comments-count">
                &nbsp; | &nbsp;
                <a href="{{ url_for(post.path) }}#comments" itemprop="discussionUrl">
                  <span class="post-comments-count ds-thread-count" data-thread-key="{{ post.path }}" itemprop="commentsCount"></span>
                </a>
              </span>
            {% elseif theme.disqus_shortname %}
              <span class="post-comments-count">
              &nbsp; | &nbsp;
              <a href="{{ url_for(post.path) }}#comments" itemprop="discussionUrl">
                <span class="post-comments-count disqus-comment-count" data-disqus-identifier="{{ post.path }}" itemprop="commentsCount"></span>
              </a>
            </span>
            {% endif %}
          {% endif %}

          {% if not is_index and theme.facebook_sdk.enable and theme.facebook_sdk.like_button %}
            &nbsp; | &nbsp;
            <div class="fb-like" data-layout="button_count" data-share="true"></div>
          {% endif %}

        </div>
      </header>
    {% endif %}


    <div class="post-body">

      {# Gallery support #}
      {% if post.photos and post.photos.length %}
        <div class="post-gallery" itemscope itemtype="http://schema.org/ImageGallery">
          {% set COLUMN_NUMBER = 3 %}
          {% for photo in post.photos %}
            {% if loop.index0 % COLUMN_NUMBER === 0 %}<div class="post-gallery-row">{% endif %}
              <a class="post-gallery-img fancybox"
                 href="{{ url_for(photo) }}" rel="gallery_{{ post._id }}"
                 itemscope itemtype="http://schema.org/ImageObject" itemprop="url">
                <img src="{{ url_for(photo) }}" itemprop="contentUrl"/>
              </a>
            {% if loop.index0 % COLUMN_NUMBER === 2 %}</div>{% endif %}
          {% endfor %}

          {# Append end tag for `post-gallery-row` when (photos size mod COLUMN_NUMBER) is less than COLUMN_NUMBER #}
          {% if post.photos.length % COLUMN_NUMBER > 0 %}</div>{% endif %}
        </div>
      {% endif %}

      {% if is_index %}
        {% if post.description %}
          <span itemprop="description">{{ post.description }}</span>
          <div class="post-more-link text-center">
            <a class="btn" href="{{ url_for(post.path) }}">
              {{ __('post.read_more') }} &raquo;
            </a>
          </div>
        {% elif post.excerpt  %}
          {{ post.excerpt }}
          <div class="post-more-link text-center">
            <a class="btn" href="{{ url_for(post.path) }}{% if theme.scroll_to_more %}#more{% endif %}" rel="contents">
              {{ __('post.read_more') }} &raquo;
            </a>
          </div>
        {% elif theme.auto_excerpt.enable %}
          <span itemprop="articleBody">
            {% set content = post.content | striptags %}
            {{ content.substring(0, theme.auto_excerpt.length) }}
            {% if content.length > theme.auto_excerpt.length %}...{% endif %}
          </span>
          <div class="post-more-link text-center">
            <a class="btn" href="{{ url_for(post.path) }}{% if theme.scroll_to_more %}#more{% endif %}" rel="contents">
              {{ __('post.read_more') }} &raquo;
            </a>
          </div>
        {% else %}
          <span itemprop="articleBody">
            {% if post.type === 'picture' %}
              <a href="{{ url_for(post.path) }}">{{ post.content }}</a>
            {% else %}
              {{ post.content }}
            {% endif %}
          </span>
        {% endif %}
      {% else %}
        <span itemprop="articleBody">{{ post.content }}</span>
      {% endif  %}
    </div>

    <footer class="post-footer">
      {% if post.tags and post.tags.length and not is_index %}
        <div class="post-tags">

        <div class="copyright_init">
          <p><span>本文标题:</span><a href="{{ url_for(post.path) }}">{{ post.title or post.link }}</a></p>
          <p><span>文章作者:</span><a href="/" title="访问 <%=theme.author%> 的个人博客">{{ theme.author }}</a></p>
          <p><span>发布时间:</span>{{ post.date.format("HH:mm MMM DD YYYY") }}</p>
          <p><span>最后更新:</span>{{ post.updated.format("HH:mm MMM DD YYYY") }}</p>
          <p>
            <span>原始链接:</span><a href="{{ url_for(post.path) }}" title="{{ post.title or post.path }}">{{ url_for(post.path) }}</a>
            <span class="btn_init" data-clipboard-text="原文: {{ url_for(post.path) }}　　作者: {{ theme.author }}" title="点击复制文章链接">
                <i class="fa fa-clipboard"></i>
            </span>
          </p>
          <p><span>许可协议:</span><i class="fa fa-creative-commons"></i> <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/cn/" title="中国大陆 (CC BY-NC-SA 3.0 CN)">"署名-非商用-相同方式共享 3.0"</a> 转载请保留原文链接及作者。</p>
          <script src="/js/clipboard.min.js"></script>
          <script> var clipboard = new Clipboard('.btn_init'); </script>
        </div>
        <style type="text/css">
          .copyright_init p .btn_init {
            margin-left: 1em;
          }
          .copyright_init:hover p .btn_init::after {
            content: "复制"
          }
          .copyright_init p .btn_init:hover {
              color: gray;
              cursor: pointer;
            };
        </style>

          {% for tag in post.tags %}
            <a href="{{ url_for(tag.path) }}" rel="tag">#{{ tag.name }}</a>
          {% endfor %}
        </div>
      {% endif %}

      {% if not is_index and (post.prev or post.next) and not navlessPost %}
        <div class="post-nav">
          <div class="post-nav-next post-nav-item">
            {% if post.next %}
              <a href="{{ url_for(post.next.path) }}" rel="next" title="{{ post.next.title }}">
                <i class="fa fa-chevron-left"></i> {{ post.next.title }}
              </a>
            {% endif %}
          </div>

          <div class="post-nav-prev post-nav-item">
            {% if post.prev %}
              <a href="{{ url_for(post.prev.path) }}" rel="prev" title="{{ post.prev.title }}">
                {{post.prev.title}} <i class="fa fa-chevron-right"></i>
              </a>
            {% endif %}
          </div>
        </div>
      {% endif %}

      {% set isLast = loop.index % page.per_page === 0 %}
      {% if is_index and not isLast %}
        <div class="post-eof"></div>
      {% endif %}
    </footer>
  </article>

{% endmacro %}
